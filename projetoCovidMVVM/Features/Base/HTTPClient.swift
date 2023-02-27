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
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        print(urlComponents.url as Any)
        
        guard let url = urlComponents.url
        else
        {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

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
                    decoder.assumesTopLevelDictionary = true
                    decoder.dataDecodingStrategy = .deferredToData
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
                
                    do {
                        let decodedResponse = try decoder.decode(responseModel, from: data)
                        print(decodedResponse as Any)
                        //return .success(decodedResponse!)
                    }
                    catch
                    {
                        print(error)
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
