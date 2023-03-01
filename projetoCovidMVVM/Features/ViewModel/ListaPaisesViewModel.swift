//
//  ListaPaisesViewModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 23/02/23.
//

import Foundation
import OSLog

protocol PaisListaViewModel: ObservableObject
{
    func getListaPaises() async
}

@MainActor
final class PaisListaViewModelImpl: PaisListaViewModel
{
    enum State
    {
        case na
        case loading
        case success(data: PaisModel)
        case failed(error: Error)
    }

    @Published private(set) var paises: PaisModel = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    
    private let service: NetworkService

    init(service: NetworkService)
    {
        self.service = service
    }
    
    func getListaPaises() async
    {
        self.state = .loading
        self.hasError = false
        self.carregando = true
        
        let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: "main")
        logger.trace("Iniciando fetch")
        
        let result = await service.getListaPaises()
        switch result
        {
        case .success(let data):
            self.state = .success(data: data)
            self.carregando = false
        case .failure(let error):
            self.state = .failed(error: error)
            self.hasError = true
            self.carregando = false
            print("Erro viewmodel")
            print(String(describing: error))
            logger.error("\(error.localizedDescription, privacy: .public)")
        }
        logger.trace("Finalizando fetch")
    }
}
