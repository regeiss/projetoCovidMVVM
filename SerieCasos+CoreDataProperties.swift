//
//  SerieCasos+CoreDataProperties.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/03/23.
//
//

import Foundation
import CoreData


extension SerieCasos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SerieCasos> {
        return NSFetchRequest<SerieCasos>(entityName: "SerieCasos")
    }

    @NSManaged public var data: Date?
    @NSManaged public var qtd: Int32

}

extension SerieCasos : Identifiable {

}
