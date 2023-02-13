//
//  MundialModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

struct MundialModel: Codable, Hashable
{
    let population: Int
    let cases: Int
    let active: Int
    let deaths: Int
    let recovered: Int
}
//covidAll{
//updated    number
//cases    number
//todayCases    number
//deaths    number
//recovered    number
//todayRecovered    number
//active    number
//critical    number
//casesPerOneMillion    number
//deathsPerOneMillion    number
//tests    number
//testsPerOneMillion    number
//population    number
//oneCasePerPeople    number
//oneDeathPerPeople    number
//oneTestPerPeople    number
//activePerOneMillion    number
//recoveredPerOneMillion    number
//criticalPerOneMillion    number
//affectedCountries    number
//}
