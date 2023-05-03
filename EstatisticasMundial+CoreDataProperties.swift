//
//  EstatisticasMundial+CoreDataProperties.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 02/05/23.
//
//

import Foundation
import CoreData


extension EstatisticasMundial {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EstatisticasMundial> {
        return NSFetchRequest<EstatisticasMundial>(entityName: "EstatisticasMundial")
    }

    @NSManaged public var active: Int32
    @NSManaged public var cases: Int32
    @NSManaged public var critical: Int32
    @NSManaged public var deaths: Int32
    @NSManaged public var population: Int64
    @NSManaged public var recovered: Int32
    @NSManaged public var todayCases: Int32
    @NSManaged public var todayRecovered: Int32
    @NSManaged public var updatedDate: Double

}

extension EstatisticasMundial : Identifiable {

}
