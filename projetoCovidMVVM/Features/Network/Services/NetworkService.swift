//
//  NetworkService.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation

protocol NetworkServiceable
{
    func getEstatisticas() async -> Result<MundialModel, RequestError>
    func getListaPaises() async -> Result<PaisModel, RequestError>
    func getInfoContinentes() async -> Result<ContinenteModel, RequestError>
}

class NetworkService: HTTPClient, NetworkServiceable
{
    func getEstatisticas() async -> Result<MundialModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.estatisticas, responseModel: MundialModel.self)
    }
    
    func getListaPaises() async -> Result<PaisModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.lista, responseModel: PaisModel.self)
    }

    func getInfoContinentes() async -> Result<ContinenteModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.continente, responseModel: ContinenteModel.self)
    }
}
