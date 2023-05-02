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
        newMundial.cases = mundial.cases
        newMundial.todayCases = mundial.todayCases
        newMundial.deaths = mundial.deaths
        newMundial.recovered = mundial.recovered
        newMundial.todayRecovered = mundial.todayRecovered
        newMundial.active = mundial.active
        newMundial.critical = mundial.critical
        newMundial.casesPerOneMillion = mundial.casesPerOneMillion
        newMundial.deathsPerOneMillion = mundial.deathsPerOneMillion
        newMundial.tests = mundial.tests
        newMundial.testsPerOneMillion = mundial.testsPerOneMillion
        newMundial.population = mundial.population
        newMundial.oneCasePerPeople = mundial.oneCasePerPeople
        newMundial.oneDeathPerPeople = mundial.oneDeathPerPeople
        newMundial.oneTestPerPeople = mundial.oneTestPerPeople
        newMundial.activePerOneMillion = mundial.activePerOneMillion
        newMundial.recoveredPerOneMillion = mundial.recoveredPerOneMillion
        newMundial.criticalPerOneMillion = mundial.criticalPerOneMillion
        newMundial.affectedCountries = mundial.affectedCountries

        save()
    }
    
    func save()
    {
        publisherContext.performAndWait
        {
            do
            {
                try newMundial.publisherContext.save()
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



