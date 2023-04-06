//
//  MundialModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

struct MundialModel: Codable, Hashable
{
    init(updated: Double, cases: Int, todayCases: Int, deaths: Int, recovered: Int, todayRecovered: Int, active: Int, critical: Int, casesPerOneMillion: Int,
        deathsPerOneMillion: Double, tests: Int, testsPerOneMillion: Double, population: Int, oneCasePerPeople: Int, oneDeathPerPeople: Int, oneTestPerPeople: Int,
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
    let population: Int
    let oneCasePerPeople: Int
    let oneDeathPerPeople: Int
    let oneTestPerPeople: Int
    let activePerOneMillion: Double
    let recoveredPerOneMillion: Double
    let criticalPerOneMillion: Double
    let affectedCountries: Int
}

extension MundialModel {
    
    func getTodayCases(offset: Int = 1) -> Int {
        return self.cases
    }
    
    func getTodayDeaths(offset: Int = 1) -> Int {
        return self.deaths
    }
    
    func hasRecoveredData() -> Bool {
        return self.recovered != 0
    }
    
    func getTodayRecovered(offset: Int = 1) -> Int? {
        return self.recovered
    }
    
    func getTodayNewCases(offset: Int = 1) -> Int {
        return self.getTodayCases(offset: offset) - self.getTodayCases(offset: offset+1)
    }
    
    func getTodayNewDeath(offset: Int = 1) -> Int {
        return self.getTodayDeaths(offset: offset) - self.getTodayDeaths(offset: offset+1)
    }
    
    func getFatality(offset: Int = 1) -> String {
        let fatality = Float (self.getTodayDeaths(offset: offset)) / Float (self.getTodayCases(offset: offset)) * Float (100)
        return String(format: "%.2f", fatality) + "%"
    }
    
    func getDailyGrowthRate(offset: Int = 1) -> String {
        let dailyGrowthRate = Float (self.getTodayNewCases(offset: offset)) / Float(self.getTodayNewCases(offset: offset+1))  * Float (100)
        return String(format: "%.2f", dailyGrowthRate) + "%"
    }
    
    func get14DaysGrowthRate(offset: Int = 1) -> String {
//        if MundialModel.dataLength-offset-26 > 0 {
//            let growth = self.cases![MundialModel.dataLength-(offset+13)...MundialModel.dataLength-offset].reduce(0, +)
//            let base = self.cases![MundialModel.dataLength-(offset+28)...MundialModel.dataLength-(offset+15)].reduce(0, +)
//            let fourteenDaysGrowthRate = Float (growth) / Float(base)  * Float (100)
//            return String(format: "%.2f", fourteenDaysGrowthRate) + "%"
//        }
        return "N/A"
    }
}
