//
//  SeriesHistoricasPublisher.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/03/23.
//

import Foundation
import CoreData
import Combine
import OSLog
import SwiftUI

class SeriesHistoricasPublisher: NSObject
{
    private var viewModel = MundialSeriesViewModelImpl(service: NetworkService())
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
    
    private func backgroundTaskContext() -> NSManagedObjectContext
    {
        let taskContext = PersistenceController.shared.container.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        return taskContext
    }
    
//    private func newBatchInsertRequest(with propertyList: [SeriesHistoricas]) -> NSBatchInsertRequest
//    {
//        var index = 0
//        let total = propertyList.count
//
//        // Provide one dictionary at a time when the closure is called.
//        let batchInsertRequest = NSBatchInsertRequest(entity: SeriesHistoricas.entity(), dictionaryHandler: { dictionary in
//            guard index < total else { return true }
//            dictionary.addEntries(from: propertyList[index].dictionaryValue)
//            index += 1
//            return false
//        })
//        return batchInsertRequest
//    }
//
//    func fetchSeries() async throws
//    {
//        do
//        {
//            logger.debug("Start importing data to the store...")
//            await viewModel.getSerieHistorica()
//            logger.debug("Finished importing data.")
//            switch viewModel.state
//            {
//            case .loading:
//                LoadingView(text: "Buscando")
//
//            case .success(let data):
//
//
//                ForEach(data.articles, id: \.id) { artigo in
//                    ArtigoPainelCompactoView(artigo: artigo)
//                }
//
//
//            case .failed(let error):
//                ErroView(erro: error)
//
//            default: return
//            }
//        }
//        catch
//        {
//            throw DataError.wrongDataFormat(error: error)
//        }
//    }
//
//    private func importSeriesHistoricas(from propertiesList: [SeriesHistoricas]) async throws
//    {
//        guard !propertiesList.isEmpty else { return }
//
//        let taskContext = backgroundTaskContext()
//        taskContext.name = "importContext"
//        taskContext.transactionAuthor = "importQuakes"
//
//        try await taskContext.perform
//        {
//            // Execute the batch insert.
//            /// - Tag: batchInsertRequest
//            let batchInsertRequest = self.newBatchInsertRequest(with: propertiesList)
//            if let fetchResult = try? taskContext.execute(batchInsertRequest),
//               let batchInsertResult = fetchResult as? NSBatchInsertResult,
//               let success = batchInsertResult.result as? Bool, success {
//                return
//            }
//            self.logger.debug("Failed to execute batch insert request.")
//            throw DataError.batchInsertError
//        }
//
//        logger.debug("Successfully inserted data.")
//    }

//    func importProducts()
//    {
//        await viewModel.getSerieHistorica()
//            switch result {
//            case .success(let products):
//                self.persistenceController.container.performBackgroundTask { context in
//                    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//                    let batchInsert = NSBatchInsertRequest(entityName: "Product", objects: products)
//                    do {
//                        let result = try context.execute(batchInsert) as! NSBatchInsertResult
//                        print(result)
//                    }
//                    catch {
//                        let nsError = error as NSError
//                        // TODO: handle errors
//                    }
//                    //          DispatchQueue.main.async {
//                    //            objectWillChange.send()
//                    //            // TODO: handle errors
//                    //            try? resultsController.performFetch()
//                    //          }
//                }
//            }
//        }
//    }
}
