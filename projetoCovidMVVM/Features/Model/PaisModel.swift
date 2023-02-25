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
    let updated: Double
    let country: String
    let countryInfo: PaisInfo
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let todayRecovered: Int
    let active: Int
    let critical: Int
    let casesPerOneMillion: Double
    let deathsPerOneMillion: Double
    let tests: Int
    let testsPerOneMillion: Double
    let population: Int
    let continent: Int
    let oneCasePerPeople: Int
    let oneDeathPerPeople: Int
    let oneTestPerPeople: Int
    let activePerOneMillion: Double
    let recoveredPerOneMillion: Double
    let criticalPerOneMillion: Double

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

