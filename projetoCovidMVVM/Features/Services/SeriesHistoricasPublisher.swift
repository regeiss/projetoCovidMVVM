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

//class SeriesHistoricasPublisher: NSObject
//{
//    private var viewModel = MundialSeriesViewModelImpl(service: NetworkService())
//    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
//
//    private func backgroundTaskContext() -> NSManagedObjectContext
//    {
//        let taskContext = PersistenceController.shared.container.newBackgroundContext()
//        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        taskContext.undoManager = nil
//        return taskContext
//    }
//
//    func insereSerie() async
//    {
//        let taskContext = backgroundTaskContext()
//
//        await viewModel.getSerieHistorica()
//
//        switch result
//        {
//        case .success(let data):
//            try await taskContext.perform
//            {
//                // Execute the batch insert.
//                /// - Tag: batchInsertRequest
//                let batchInsertRequest = NSBatchInsertRequest(entityName: "Product", objects: data)
//                if let fetchResult = try? taskContext.execute(batchInsertRequest),
//                   let batchInsertResult = fetchResult as? NSBatchInsertResult,
//                   let success = batchInsertResult.result as? Bool, success {
//                    return
//                }
//                self.logger.debug("Failed to execute batch insert request.")
//                throw DataError.batchInsertError
//            }
//            //            self.persistenceController.container.performBackgroundTask { context in
//            //                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//            //                let batchInsert = NSBatchInsertRequest(entityName: "Product", objects: data)
//            //                do {
//            //                    let result = try context.execute(batchInsert) as! NSBatchInsertResult
//            //                    print(result)
//            //                }
//            //                catch
//            //                {
//            //                    let nsError = error as NSError
//            //                    // TODO: handle errors
//            //                }
//            //                //          DispatchQueue.main.async {
//            //                //            objectWillChange.send()
//            //                //            // TODO: handle errors
//            //                //            try? resultsController.performFetch()
//            //                //          }
//        }
//    }
//}


