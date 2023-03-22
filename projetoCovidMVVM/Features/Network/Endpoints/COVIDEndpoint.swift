//
//  MundialEndpoint.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/02/23.
//

import Foundation

enum COVIDEndpoint
{
    case estatisticas
    case serie14dias
    case serie30dias
    case serie90dias
    case lista
    case continente
    case artigos
}

extension COVIDEndpoint: Endpoint
{
    var host: String
    {
        switch self
        {
        case .estatisticas, .lista, .continente, .serie14dias, .serie30dias, .serie90dias:
            return "disease.sh"
        case .artigos:
            return "newsapi.org"
        }
    }
    
    var path: String
    {
        switch self
        {
        case .estatisticas:
            return "/v3/covid-19/all"
        case .lista:
            return "/v3/covid-19/countries"
        case .continente:
            return "/v3/covid-19/continents"
        case .artigos:
            return "/v2/everything"
        case .serie14dias, .serie30dias, .serie90dias:
            return "/v3/covid-19/historical/all"
        }
    }
    
    var method: RequestMethod
    {
        switch self
        {
        case .estatisticas, .lista, .continente, .serie14dias, .serie30dias, .serie90dias, .artigos:
            return .get
        }
    }
    
    var header: [String : String]?
    {
        return nil
    }
    
    var body: [String : String]?
    {
        return nil
    }
    
    var series: Int
    {
        switch self
        {
        case .serie14dias:
            return 14
        case .serie30dias:
            return 30
        case .serie90dias:
            return 90
        default: return 0
        }
    }
}
