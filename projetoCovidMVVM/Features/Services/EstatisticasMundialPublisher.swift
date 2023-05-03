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
        newMundial.updatedDate = Double(mundial.updated)
        newMundial.cases = Int32(mundial.cases)
        newMundial.todayCases = Int32(mundial.todayCases)
        newMundial.deaths = Int32(mundial.deaths)
        newMundial.recovered = Int32(mundial.recovered)
        newMundial.todayRecovered = Int32(mundial.todayRecovered)
        newMundial.active = Int32(mundial.active)
        newMundial.critical = Int32(mundial.critical)
//        newMundial.casesPerOneMillion = mundial.casesPerOneMillion
//        newMundial.deathsPerOneMillion = mundial.deathsPerOneMillion
//        newMundial.tests = mundial.tests
//        newMundial.testsPerOneMillion = mundial.testsPerOneMillion
        newMundial.population = Int64(mundial.population)
//        newMundial.oneCasePerPeople = mundial.oneCasePerPeople
//        newMundial.oneDeathPerPeople = mundial.oneDeathPerPeople
//        newMundial.oneTestPerPeople = mundial.oneTestPerPeople
//        newMundial.activePerOneMillion = mundial.activePerOneMillion
//        newMundial.recoveredPerOneMillion = mundial.recoveredPerOneMillion
//        newMundial.criticalPerOneMillion = mundial.criticalPerOneMillion
//        newMundial.affectedCountries = mundial.affectedCountries

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



