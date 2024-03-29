//
//  SeriesHistoricas+CoreDataProperties.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/03/23.
//
//

import Foundation
import CoreData

extension SeriesHistoricas
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeriesHistoricas>
    {
        return NSFetchRequest<SeriesHistoricas>(entityName: "SeriesHistoricas")
    }

    @NSManaged public var tipo: String?
    @NSManaged public var qtd: Int32
    @NSManaged public var data: Date?

    var dictionaryValue: [String: Any]
    {
        [
            "tipo": tipo as Any,
            "qtd": qtd,
            "data": data as Any
        ]
    }
}

extension SeriesHistoricas : Identifiable
{

}
