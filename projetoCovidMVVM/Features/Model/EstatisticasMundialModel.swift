//
//  MundialModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

struct EstatisticasMundialModel: Codable, Hashable
{
    init(updated: Double, cases: Int, todayCases: Int, deaths: Int, recovered: Int, todayRecovered: Int, active: Int, critical: Int, casesPerOneMillion: Int,
        deathsPerOneMillion: Double, tests: Int, testsPerOneMillion: Double, population: Int64, oneCasePerPeople: Int, oneDeathPerPeople: Int, oneTestPerPeople: Int,
        activePerOneMillion: Double, recoveredPerOneMillion: Double, criticalPerOneMillion: Double, affectedCountries: Int)
    {
        self.updated = updated
        self.cases = cases
        self.todayCases = todayCases
        self.deaths = deaths
        self.recovered = recovered
        
        self.todayRecovered = todayRecovered
        self.active = active
        self.critical = critical
        self.casesPerOneMillion = casesPerOneMillion
        self.deathsPerOneMillion = deathsPerOneMillion
        self.tests = tests
        self.testsPerOneMillion = testsPerOneMillion
        self.population = population
        self.oneCasePerPeople = oneCasePerPeople
        self.oneDeathPerPeople = oneDeathPerPeople
        self.oneTestPerPeople = oneTestPerPeople
        self.activePerOneMillion = activePerOneMillion
        self.recoveredPerOneMillion = recoveredPerOneMillion
        self.criticalPerOneMillion = criticalPerOneMillion
        self.affectedCountries = affectedCountries
    }
    
    let updated: Double
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let recovered: Int
    let todayRecovered: Int
    let active: Int
    let critical: Int
    let casesPerOneMillion: Int
    let deathsPerOneMillion: Double
    let tests: Int
    let testsPerOneMillion: Double
    let population: Int64
    let oneCasePerPeople: Int
    let oneDeathPerPeople: Int
    let oneTestPerPeople: Int
    let activePerOneMillion: Double
    let recoveredPerOneMillion: Double
    let criticalPerOneMillion: Double
    let affectedCountries: Int
}


