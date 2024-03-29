//
//  MundialViewModel.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import Foundation
import OSLog

protocol MundialViewModel: ObservableObject
{
    func getAllEstatisticas() async
}

@MainActor
final class MundialViewModelImpl: MundialViewModel
{
    enum State
    {
        case na
        case loading
        case success(data: EstatisticasMundialModel)
        case failed(error: Error)
    }

    @Published private(set) var mundial: [EstatisticasMundialModel] = []
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    @Published var carregando: Bool = false
    var publisher = EstatisticasMundialPublisher()
    
    private let service: NetworkService

    init(service: NetworkService)
    {
        self.service = service
    }
    
    func getAllEstatisticas() async
    {
        self.state = .loading
        self.hasError = false
        self.carregando = true
        
        let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier!, category: "main")
        logger.trace("Iniciando fetch")
        
        let result = await service.getEstatisticas()
        switch result
        {
        case .success(let data):
            self.state = .success(data: data)
            self.carregando = false
            publisher.add(mundial: data)
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
