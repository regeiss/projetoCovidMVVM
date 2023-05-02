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

        let newMundial = EstatisticasMundial(context: publisherContext)
        newMundial.updatedDate = mundial.updated
        newMundial.active = Int32(mundial.active)
        newMundial.cases = Int32(mundial.cases)
        save()
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
        fetchRequest = NSFetchRequest(entityName: "EstatisticasMundial")

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



