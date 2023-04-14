//
//  Series14DiasViewModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 20/03/23.
//

import Foundation
import OSLog
import CoreData

protocol Series14DiasViewModel: ObservableObject
{
    func getSeries14Dias() async
}

@MainActor
final class Series14DiasViewModelImpl: Series14DiasViewModel
{
    enum State
    {
        case na
        case loading
        case success(data: MundialSeriesModel)
        case failed(error: Error)
    }

    @Published private(set) var series: [MundialSeriesModel] = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    
    private let service: NetworkService

    var publisherContext: NSManagedObjectContext = {
         let context = PersistenceController.shared.container.viewContext
         context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
         context.automaticallyMergesChangesFromParent = true
         return context
     }()
    
    init(service: NetworkService)
    {
        self.service = service
    }
    
    func getSeries14Dias() async
    {
        self.state = .loading
        self.hasError = false
        self.carregando = true
        
        let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: "main")
        logger.trace("Iniciando fetch")
        
        let result = await service.getSeries14dias()
        switch result
        {
        case .success(let data):
            self.state = .success(data: data)
            self.carregando = false
            
            data.cases.forEach({ (casos) in
                let newSerie = SeriesHistoricas(context: publisherContext)
                newSerie.data = casos.key.toDate(withFormat: "MM-dd-yyyy")
                newSerie.qtd = Int32(casos.value)
                newSerie.tipo = "casos"
                add()
            })
            
            data.deaths.forEach({ (casos) in
                let newSerie = SeriesHistoricas(context: publisherContext)
                newSerie.data = casos.key.toDate(withFormat: "MM-dd-yyyy")
                newSerie.qtd = Int32(casos.value)
                newSerie.tipo = "mortes"
                add()
            })
            
            data.recovered.forEach({ (casos) in
                let newSerie = SeriesHistoricas(context: publisherContext)
                newSerie.data = casos.key.toDate(withFormat: "MM-dd-yyyy")
                newSerie.qtd = Int32(casos.value)
                newSerie.tipo = "recuperados"
                add()
            })
            
        case .failure(let error):
            self.state = .failed(error: error)
            self.hasError = true
            self.carregando = false
            print(String(describing: error))
            logger.error("\(error.localizedDescription, privacy: .public)")
        }
        logger.trace("Finalizando fetch")
    }
    
    func add()
     {
         publisherContext.performAndWait
         {
             do
             {
                 try self.publisherContext.save()
             }
             catch
             {
                 fatalError("Erro moc \(error.localizedDescription)")
             }
         }
     }
//    func getFatality(offset: Int = 1) -> String {
//        let fatality = Float (self.getTodayDeaths(offset: offset)) / Float (self.getTodayCases(offset: offset)) * Float (100)
//        return String(format: "%.2f", fatality) + "%"
//    }
//
//    func getDailyGrowthRate(offset: Int = 1) -> String {
//        let dailyGrowthRate = Float (self.getTodayNewCases(offset: offset)) / Float(self.getTodayNewCases(offset: offset+1))  * Float (100)
//        return String(format: "%.2f", dailyGrowthRate) + "%"
//    }
//
//    func get14DaysGrowthRate(offset: Int = 1) -> String {
//        if CovidDataModel.dataLength-offset-26 > 0 {
//            let growth = self.cases![CovidDataModel.dataLength-(offset+13)...CovidDataModel.dataLength-offset].reduce(0, +)
//            let base = self.cases![CovidDataModel.dataLength-(offset+28)...CovidDataModel.dataLength-(offset+15)].reduce(0, +)
//            let fourteenDaysGrowthRate = Float (growth) / Float(base)  * Float (100)
//            return String(format: "%.2f", fourteenDaysGrowthRate) + "%"
//        }
//        return "N/A"
//    }
}
