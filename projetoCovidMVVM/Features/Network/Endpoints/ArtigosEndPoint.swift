//
//  ArtigosEndPoint.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 07/03/23.
//

import Foundation

enum ArtigosEndpoint
{
    case artigos
}

extension ArtigosEndpoint: EndpointA
{
    var path: String
    {
        switch self
        {
            case .artigos:
                return "/v2/top-headlines?country=us&apiKey=26995ba0201c407da84ab37262254c9b"
        }
    }
    
    var method: RequestMethod
    {
        switch self
        {
        case .artigos:
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
