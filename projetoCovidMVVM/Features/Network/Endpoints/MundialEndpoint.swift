//
//  MundialEndpoint.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/02/23.
//

import Foundation

enum MundialEndpoint
{
    case estatisticas
}

extension MundialEndpoint: Endpoint
{
    var path: String
    {
        switch self
        {
            case .estatisticas:
                return "/all"
        }
    }
    
    var method: RequestMethod
    {
        switch self
        {
            case .estatisticas:
                return .get
        }
    }
    
    var header: [String : String]?
    {
        let accessToken = "token"
        return ["Authorization": "zero","Content-type":"json;charset=utf-8"]
    }
    
    var body: [String : String]?
    {
        return nil
    }
    
    
}
