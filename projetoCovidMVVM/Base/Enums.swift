//
//  Enums.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 19/03/23.
//

import Foundation

enum LoadingPeriod
{
    case week
    case month
    case threeMonth
}

enum DataCategory
{
    case cases, deaths, recovered
}

enum CumulativeOrNew
{
    case cumulative, new
}

enum LogOrValue
{
    case log, value
}
