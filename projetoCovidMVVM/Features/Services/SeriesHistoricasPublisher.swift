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

class SeriesHistoricasPublisher: NSObject
{
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
    
    var publisherContext: NSManagedObjectContext = {
        let context = PersistenceController.shared.container.viewContext
        context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    func add(series: MundialSeriesModel)
    {
        deleteAll()
        
        series.cases.forEach({ (casos) in
            let newSerie = SeriesHistoricas(context: publisherContext)
            newSerie.data = casos.key.toDate(withFormat: "MM-dd-yyyy")
            newSerie.qtd = Int32(casos.value)
            newSerie.tipo = "casos"
            save()
        })
        
        series.deaths.forEach({ (casos) in
            let newSerie = SeriesHistoricas(context: publisherContext)
            newSerie.data = casos.key.toDate(withFormat: "MM-dd-yyyy")
            newSerie.qtd = Int32(casos.value)
            newSerie.tipo = "mortes"
            save()
        })
        
        series.recovered.forEach({ (casos) in
            let newSerie = SeriesHistoricas(context: publisherContext)
            newSerie.data = casos.key.toDate(withFormat: "MM-dd-yyyy")
            newSerie.qtd = Int32(casos.value)
            newSerie.tipo = "recuperados"
            save()
        })
    }
    
    func save()
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
    
    func deleteAll()
    {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "SeriesHistoricas")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        let context = publisherContext
        
        do
        {
            let batchDelete = try context.execute(deleteRequest) as? NSBatchDeleteResult
            guard let deleteResult = batchDelete?.result
                    as? [NSManagedObjectID]
            else { return }
            
            let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]
            
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: deletedObjects, into: [context])
        }
        catch
        {
            fatalError("Erro moc \(error.localizedDescription)")
        }
    }
}


