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
    func getSeries14dias() async -> Result<MundialSeriesModel, RequestError>
    func getSeries30dias() async -> Result<MundialSeriesModel, RequestError>
    func getSeries90dias() async -> Result<MundialSeriesModel, RequestError>
    func getListaPaises() async -> Result<PaisModel, RequestError>
    func getInfoContinentes() async -> Result<ContinenteModel, RequestError>
    func getAllArtigos() async -> Result<ArtigoModel, RequestError>
}

class NetworkService: HTTPClient, NetworkServiceable
{
    func getEstatisticas() async -> Result<MundialModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.estatisticas, responseModel: MundialModel.self)
    }
    
    func getSeries14dias() async -> Result<MundialSeriesModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.serie14dias, responseModel: MundialSeriesModel.self)
    }
    
    func getSeries30dias() async -> Result<MundialSeriesModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.serie30dias, responseModel: MundialSeriesModel.self)
    }
    
    func getSeries90dias() async -> Result<MundialSeriesModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.serie90dias, responseModel: MundialSeriesModel.self)
    }
    
    func getListaPaises() async -> Result<PaisModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.lista, responseModel: PaisModel.self)
    }

    func getInfoContinentes() async -> Result<ContinenteModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.continente, responseModel: ContinenteModel.self)
    }
    
    func getAllArtigos() async -> Result<ArtigoModel, RequestError>
    {
        return await sendRequest(endpoint: COVIDEndpoint.artigos, responseModel: ArtigoModel.self)
    }
}
