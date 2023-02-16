//
//  URLEndPoint.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

protocol APIBuilder
{
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum NetworkAPI
{
    case total
    case lista
    case pais
}

extension NetworkAPI: APIBuilder
{
    // let status: String = ifDaily ? "historical" : "countries"
    // let duration: String = ifDaily ? "?lastdays=365" : ""
    // var endpoint: String = baseURL + "all"

    var baseUrl: URL
    {
        switch self
        {
        case .total:
            return URL(string: "https://disease.sh/v3/covid-19/")!
        case .pais:
            return URL(string: "https://disease.sh/v3/")!
        case .lista:
            return URL(string: "https://disease.sh/v3/")!
        }
    }
    
    var path: String
    {
        switch self
        {
            case .total:
            return "all"
        case .pais:
            return "all"
        case .lista:
            return "all"
        }
    }
    
    var urlRequest: URLRequest
    {
        switch self
        {
            case .total:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        case .pais:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        case .lista:
            return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
        }
    }
}
