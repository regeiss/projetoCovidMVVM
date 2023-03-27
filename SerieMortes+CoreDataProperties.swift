//
//  SerieMortes+CoreDataProperties.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/03/23.
//
//

import Foundation
import CoreData


extension SerieMortes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SerieMortes> {
        return NSFetchRequest<SerieMortes>(entityName: "SerieMortes")
    }

    @NSManaged public var data: Date?
    @NSManaged public var qtd: Int32

}

extension SerieMortes : Identifiable {

}
