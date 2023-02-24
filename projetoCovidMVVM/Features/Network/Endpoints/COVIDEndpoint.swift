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
}

extension COVIDEndpoint: Endpoint
{
    var path: String
    {
        switch self
        {
            case .estatisticas:
                return "/v3/covid-19/all"
            case .lista:
                return "/v3/covid-19/all"
        }
    }
    
    var method: RequestMethod
    {
        switch self
        {
        case .estatisticas, .lista:
                return .get
        }
    }
    
    var header: [String : String]?
    {
//        let accessToken = "token"
//        return ["Authorization": "zero","Content-type":"json;charset=utf-8"]
        nil 
    }
    
    var body: [String : String]?
    {
        return nil
    }
    
    
}
