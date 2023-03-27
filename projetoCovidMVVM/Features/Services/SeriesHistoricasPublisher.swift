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

class SeriesHistoricasPublisher: NSObject, ObservableObject
{
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
    
    /// Creates and configures a private queue context.
    private func newTaskContext() -> NSManagedObjectContext
    {
        // Create a private queue context.
        /// - Tag: newBackgroundContext
        let taskContext = PersistenceController.shared.container.viewContext
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // Set unused undoManager to nil for macOS (it is nil by default on iOS)
        // to reduce resource requirements.
        taskContext.undoManager = nil
        return taskContext
    }
    
    private func newBatchInsertRequest(with propertyList: [SeriesHistoricas]) -> NSBatchInsertRequest
    {
        var index = 0
        let total = propertyList.count
        
        // Provide one dictionary at a time when the closure is called.
        let batchInsertRequest = NSBatchInsertRequest(entity: SeriesHistoricas.entity(), dictionaryHandler: { dictionary in
            guard index < total else { return true }
            dictionary.addEntries(from: propertyList[index].dictionaryValue)
            index += 1
            return false
        })
        return batchInsertRequest
    }
    
    func fetchSeries() async throws
    {
//        let session = URLSession.shared
//        guard let (data, response) = try? await session.data(from: url),
//              let httpResponse = response as? HTTPURLResponse,
//              httpResponse.statusCode == 200
//        else
//        {
//            logger.debug("Failed to received valid response and/or data.")
//            throw DataError.missingData
//        }
//
//        do
//        {
//            // Decode the GeoJSON into a data model.
//            let jsonDecoder = JSONDecoder()
//            jsonDecoder.dateDecodingStrategy = .secondsSince1970
//            let geoJSON = try jsonDecoder.decode(GeoJSON.self, from: data)
//            let quakePropertiesList = geoJSON.quakePropertiesList
//            logger.debug("Received \(quakePropertiesList.count) records.")
//
//            // Import the GeoJSON into Core Data.
//            logger.debug("Start importing data to the store...")
//            try await importSeriesHistoricas(from: quakePropertiesList)
//            logger.debug("Finished importing data.")
//        }
//        catch
//        {
//            throw DataError.wrongDataFormat(error: error)
//        }
    }
    
    /// Uses `NSBatchInsertRequest` (BIR) to import a JSON dictionary into the Core Data store on a private queue.
    private func importSeriesHistoricas(from propertiesList: [SeriesHistoricas]) async throws
    {
        guard !propertiesList.isEmpty else { return }
        
        let taskContext = newTaskContext()
        // Add name and author to identify source of persistent history changes.
        taskContext.name = "importContext"
        taskContext.transactionAuthor = "importQuakes"
        
        /// - Tag: performAndWait
        try await taskContext.perform
        {
            // Execute the batch insert.
            /// - Tag: batchInsertRequest
            let batchInsertRequest = self.newBatchInsertRequest(with: propertiesList)
            if let fetchResult = try? taskContext.execute(batchInsertRequest),
               let batchInsertResult = fetchResult as? NSBatchInsertResult,
               let success = batchInsertResult.result as? Bool, success {
                return
            }
            self.logger.debug("Failed to execute batch insert request.")
            throw DataError.batchInsertError
        }
        
        logger.debug("Successfully inserted data.")
    }
}
