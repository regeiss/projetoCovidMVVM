//
//  RequestError.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/02/23.
//

import Foundation

enum RequestError: Error 
{
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String 
    {
        switch self 
        {
            case .decode:
                return "Decode error"
            case .unauthorized:
                return "Session expired"
            default:
                return "Unknown error"
        }
    }
}
