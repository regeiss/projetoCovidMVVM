//
//  PaisModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation
import MapKit

struct PaisModel: Codable, Hashable
{
    let country: String
    let countryInfo: PaisInfo
    let population: Int
    let updated: Double
    let tests: Int
    let cases: Int
    let active: Int
    let deaths: Int
    let recovered: Int

    struct PaisInfo: Codable, Hashable
    {
        let _id: Double?
        let iso2: String?
        let iso3: String?
        let lat: Double?
        let long: Double?
        let flag: String?
        // MARK: - Pais Info Computed Properties
        var location: CLLocationCoordinate2D?
        {
            CLLocationCoordinate2D(latitude: lat ?? 0, longitude: long ?? 0)
        }
    }
}

