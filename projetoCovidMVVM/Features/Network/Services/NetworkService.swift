//
//  NetworkService.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

protocol NetworkService
{   var mundial: MundialModel? { get }
    func fetch() async throws -> [MundialModel]
}

class NetworkServiceImpl: NetworkService
{
    var mundial: MundialModel?
    
    func fetch() async throws -> mundial
    //func fetch<Model: Decodable>(for country: String?, ifDaily: Bool, completed: @escaping (Model) -> ())
    {
        let urlSession = URLSession.shared
        let url = URL(string: "https://disease.sh/v3/covid-19/all")
        let (data, _) = try await urlSession.data(from: url!)
        return try JSONDecoder().decode(MundialModel.self, from: data)
    }
}
