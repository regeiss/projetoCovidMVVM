//
//  SerieRecuperados+CoreDataProperties.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/03/23.
//
//

import Foundation
import CoreData


extension SerieRecuperados {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SerieRecuperados> {
        return NSFetchRequest<SerieRecuperados>(entityName: "SerieRecuperados")
    }

    @NSManaged public var data: Date?
    @NSManaged public var qtd: Int32

}

extension SerieRecuperados : Identifiable {

}
