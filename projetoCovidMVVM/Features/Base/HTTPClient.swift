//
//  HTTPClient.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/02/23.
//

import Foundation

protocol HTTPClient 
{
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPClient 
{
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> 
    {
        // TODO: Colocar condicao para os queryitens
        //https://newsapi.org/v2/everything?q=COVID-19&apiKey=26995ba0201c407da84ab37262254c9b
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = [
           //URLQueryItem(name: "country", value: "br"),
           URLQueryItem(name: "q", value: "COVID-19"),
           //URLQueryItem(name: "sortBy", value: "publishedAt"),
           URLQueryItem(name: "apiKey", value: "26995ba0201c407da84ab37262254c9b")
        ]
        print(urlComponents.url as Any)
        
        guard let url = urlComponents.url
        else
        {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let body = endpoint.body 
        {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do 
        {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse 
            else 
            {
                return .failure(.noResponse)
            }
            
            switch response.statusCode 
            {
                case 200...299:
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                    print("Status code: ")
                    print(response.statusCode)
                    print(data)
                    print("HTTP client")
                    guard let decodedResponse = try? decoder.decode(responseModel, from: data)
                    else
                    {
                        return .failure(.decode)
                    }
 
                    print("Decode com sucesso")
                    print(decodedResponse)
                    return .success(decodedResponse)

                case 401:
                    return .failure(.unauthorized)

                default:
                    return .failure(.unexpectedStatusCode)
            }
        } 
        catch 
        {
            return .failure(.unknown)
        }
    }
}
