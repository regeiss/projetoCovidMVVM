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
        case .estatisticas, .lista, .continente:
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
            return "/v2/top-headlines"
        }
    }
    
    var method: RequestMethod
    {
        switch self
        {
        case .estatisticas, .lista, .continente, .artigos:
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
}
