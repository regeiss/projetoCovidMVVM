//
//  ContinenteModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 02/03/23.
//

import Foundation

struct ContinentElement: Codable, Identifiable
{
    let updated, cases, todayCases, deaths: Int
    let todayDeaths, recovered, todayRecovered, active: Int
    let critical: Int
    let casesPerOneMillion, deathsPerOneMillion: Double
    let tests: Int
    let testsPerOneMillion: Double
    let population: Int
    let continent: String
    let activePerOneMillion, recoveredPerOneMillion, criticalPerOneMillion: Double
    let continentInfo: ContinentInfo
    let countries: [String]
    var id: String { continent }
}

// MARK: - ContinentInfo
struct ContinentInfo: Codable
{
    let lat, long: Double
}

typealias ContinenteModel = [ContinentElement]
