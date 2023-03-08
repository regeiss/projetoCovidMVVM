//
//  ArtigosViewModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 07/03/23.
//

import Foundation
import OSLog

protocol ArtigosViewModel: ObservableObject
{
    func getAllArtigos() async
}

@MainActor
final class ArtigosViewModelImpl: ArtigosViewModel
{
    enum State
    {
        case na
        case loading
        case success(data: ArtigoModel)
        case failed(error: Error)
    }

    @Published private(set) var artigos: [ArtigoModel] = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    
    private let service: NetworkService

    init(service: NetworkService)
    {
        self.service = service
    }
    
    func getAllArtigos() async
    {
        self.state = .loading
        self.hasError = false
        self.carregando = true
        
        let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: "main")
        logger.trace("Iniciando fetch")
        
        let result = await service.getAllArtigos()
        switch result
        {
        case .success(let data):
            self.state = .success(data: data)
            self.carregando = false
        case .failure(let error):
            self.state = .failed(error: error)
            self.hasError = true
            self.carregando = false
            print(String(describing: error))
            logger.error("\(error.localizedDescription, privacy: .public)")
        }
        logger.trace("Finalizando fetch")
    }
}
