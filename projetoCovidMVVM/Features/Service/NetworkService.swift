//
//  NetworkService.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

protocol NetworkService
{
    func fetch<T: Decodable>(model: T) async throws -> [T]
}

class NetworkServiceImpl: NetworkService
{
    func fetch<Model: Decodable>(model: Model) async throws -> [Model]
    //func fetch<Model: Decodable>(for country: String?, ifDaily: Bool, completed: @escaping (Model) -> ())
    {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstants.baseURL)
        let (data, _) = try await urlSession.data(from: url!)
        return try JSONDecoder().decode([Model].self, from: data)
    }
}
