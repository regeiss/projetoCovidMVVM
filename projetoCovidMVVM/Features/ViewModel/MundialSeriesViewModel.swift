//
//  MundialSeriesViewModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 05/04/23.
//

import Foundation
import OSLog
import CoreData

protocol MundialSeriesViewModel: ObservableObject
{
    func getSerieHistorica() async
}

final class MundialSeriesViewModelImpl: MundialSeriesViewModel
{
    @Published private(set) var mundialSerie: [MundialSeriesModel] = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    
    enum State
    {
        case na
        case loading
        case success(data: MundialSeriesModel)
        case failed(error: Error)
    }
    
    private let service: NetworkService
    
    init(service: NetworkService)
    {
        self.service = service
    }
    
//    private func newBatchInsertRequest(with series: [MundialSeriesModel]) -> NSBatchInsertRequest
//    {
//        // 1
//        var index = 0
//        let total = series.count
//
//        // 2
//        let batchInsert = NSBatchInsertRequest( entity: SeriesHistoricas.entity())
//            { (managedObject: NSManagedObject) -> Bool in
//                // 3
//                guard index < total else { return true }
//
//                if let serie = managedObject as? SeriesHistoricas
//                {
//                    // 4
//                    let data = series[index]
//                    serie.tipo = data.deaths
//                    serie.qtd = data.recovered
//                    serie.data = data.cases
//
//                }
//
//                // 5
//                index += 1
//                return false
//            }
//        return batchInsert
//    }
//
//    private func batchInsertFireballs(_ fireballs: [FireballData]) {
//      // 1
//      guard !fireballs.isEmpty else { return }
//
//      // 2
//      container.performBackgroundTask { context in
//        // 3
//        let batchInsert = self.newBatchInsertRequest(with: fireballs)
//        do {
//          try context.execute(batchInsert)
//        } catch {
//          // log any errors
//        }
//      }
//    }
//
//    private func backgroundTaskContext() -> NSManagedObjectContext
//    {
//        let taskContext = PersistenceController.shared.container.newBackgroundContext()
//        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        taskContext.undoManager = nil
//        return taskContext
//    }
    
    func getSerieHistorica() async
    {
        self.state = .loading
        self.hasError = false
        self.carregando = true
        
        let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: "main")
        logger.trace("Iniciando fetch")
        
        let result = await service.getSerieHistorica()
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
}

