//
//  EstatisticasMundialPublisher.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 25/04/23.
//

import Foundation
import CoreData
import Combine
import OSLog

class EstatisticasMundialPublisher
{
    var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Publisher")
    
    var publisherContext: NSManagedObjectContext = {
        let context = PersistenceController.shared.container.viewContext
        context.mergePolicy = NSMergePolicy( merge: .mergeByPropertyObjectTrumpMergePolicyType)
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    func add(mundial: EstatisticasMundialModel)
    {
        deleteAll()
        
 
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
    
    private func newBatchInsertRequest(with estatisticas: [EstatisticasMundial]) -> NSBatchInsertRequest
    {
        // 1
        var index = 0
        let total = estatisticas.count
        
        // 2
        let batchInsert = NSBatchInsertRequest(
            entity: EstatisticasMundial.entity()) { (managedObject: NSManagedObject) -> Bool in
                // 3
                guard index < total else { return true }
                
                if let estatisticas = managedObject as? EstatisticasMundial
                {
                    // 4
                    let data = estatisticas[index]
                    estatisticas.updated =
                    estatisticas.radiatedEnergy = data.radiatedEnergy
                    estatisticas.impactEnergy = data.impactEnergy
 
                }
                
                // 5
                index += 1
                return false
            }
        return batchInsert
    }
    
    func deleteAll()
    {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "Mundial")

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



