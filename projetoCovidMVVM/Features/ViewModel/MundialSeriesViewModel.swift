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
    enum State
    {
        case na
        case loading
        case success(data: MundialSeriesModel)
        case failed(error: Error)
    }

    @Published private(set) var mundialSerie: [MundialSeriesModel] = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    
    private let service: NetworkService

    init(service: NetworkService)
    {
        self.service = service
    }

    private func backgroundTaskContext() -> NSManagedObjectContext
    {
        let taskContext = PersistenceController.shared.container.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        return taskContext
    }
    
    func getSerieHistorica() async
    {
        let taskContext = backgroundTaskContext()
        
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
            
            try await taskContext.perform
            {
                // Execute the batch insert.
                /// - Tag: batchInsertRequest
                let batchInsertRequest = NSBatchInsertRequest(entityName: "Product", objects: (data as? [[String : Any]])!)
                if let fetchResult = try? taskContext.execute(batchInsertRequest),
                   let batchInsertResult = fetchResult as? NSBatchInsertResult,
                   let success = batchInsertResult.result as? Bool, success {
                    return
                }
                logger.debug("Failed to execute batch insert request.")
                throw DataError.batchInsertError
            }
            catch
            {
                logger.error("\(error.localizedDescription, privacy: .public)")
            }
            
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

