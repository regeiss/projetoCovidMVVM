//
//  MundialSeriesModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 20/03/23.
//

import Foundation

struct MundialSeriesModel: Codable
{
    static let dataLength = 91
    
    let cases: [String: Int]
    let deaths: [String: Int]
    let recovered: [String: Int]
}

extension MundialSeriesModel
{

    func getTodayCases(offset: Int = 1) -> [String: Int]
    {
        return self.cases
    }

    func getTodayDeaths(offset: Int = 1) -> [String: Int]
    {
        return self.deaths
    }

    func hasRecoveredData() -> Bool
    {
        return self.recovered.count != 0
    }
//
//    func getTodayRecovered(offset: Int = 1) -> Int? {
//        return self.recovered
//    }
//
//    func getTodayNewCases(offset: Int = 1) -> Int {
//        return self.getTodayCases(offset: offset) - self.getTodayCases(offset: offset+1)
//    }
//
//    func getTodayNewDeath(offset: Int = 1) -> Int {
//        return self.getTodayDeaths(offset: offset) - self.getTodayDeaths(offset: offset+1)
//    }
//
//    func getFatality(offset: Int = 1) -> String {
//        let fatality = Float (self.getTodayDeaths(offset: offset)) / Float (self.getTodayCases(offset: offset)) * Float (100)
//        return String(format: "%.2f", fatality) + "%"
//    }
//
//    func getDailyGrowthRate(offset: Int = 1) -> String {
//        let dailyGrowthRate = Float (self.getTodayNewCases(offset: offset)) / Float(self.getTodayNewCases(offset: offset+1))  * Float (100)
//        return String(format: "%.2f", dailyGrowthRate) + "%"
//    }
//
//    func get14DaysGrowthRate(offset: Int = 1) -> String {
////        if MundialModel.dataLength-offset-26 > 0 {
////            let growth = self.cases![MundialModel.dataLength-(offset+13)...MundialModel.dataLength-offset].reduce(0, +)
////            let base = self.cases![MundialModel.dataLength-(offset+28)...MundialModel.dataLength-(offset+15)].reduce(0, +)
////            let fourteenDaysGrowthRate = Float (growth) / Float(base)  * Float (100)
////            return String(format: "%.2f", fourteenDaysGrowthRate) + "%"
////        }
//        return "N/A"
//    }
}
