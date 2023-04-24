//
//  MundialViewModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation
import OSLog

protocol MundialViewModel: ObservableObject
{
    func getAllEstatisticas() async
}

@MainActor
final class MundialViewModelImpl: MundialViewModel
{
    enum State
    {
        case na
        case loading
        case success(data: MundialModel)
        case failed(error: Error)
    }

    @Published private(set) var mundial: [MundialModel] = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    
    private let service: NetworkService

    init(service: NetworkService)
    {
        self.service = service
    }
    
    func getAllEstatisticas() async
    {
        self.state = .loading
        self.hasError = false
        self.carregando = true
        
        let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: "main")
        logger.trace("Iniciando fetch")
        
        let result = await service.getEstatisticas()
        switch result
        {
        case .success(let data):
            self.state = .success(data: data)
            self.carregando = false
        case .failure(let error):
            self.state = .failed(error: error)
            self.hasError = true
            self.carregando = false
            print(String(describing: error))
            logger.error("\(error.localizedDescription, privacy: .public)")
        }
        logger.trace("Finalizando fetch")
    }
    //    func getFatality(offset: Int = 1) -> String {
    //        let fatality = Float (self.getTodayDeaths(offset: offset)) / Float (self.getTodayCases(offset: offset)) * Float (100)
    //        return String(format: "%.2f", fatality) + "%"
    //    }
    //
        func getTodayCases(offset: Int = 1) -> Int
        {
            return self.cases![CovidDataModel.dataLength-offset]
        }
        
        func getDailyGrowthRate(offset: Int = 1) async -> String
        {
            let dailyGrowthRate = Float (self.getTodayNewCases(offset: offset)) / Float(self.getTodayNewCases(offset: offset+1))  * Float (100)
            return String(format: "%.2f", dailyGrowthRate) + "%"
        }
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
