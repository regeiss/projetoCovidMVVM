//
//  ContinenteListaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/03/23.
//

import SwiftUI

struct ContinenteListaView: View
{
    @StateObject private var viewModel = ContinenteViewModelImpl(service: NetworkService())
    
    var body: some View
    {
        VStack
        {
            Group
            {
                switch viewModel.state
                {
                case .loading:
                    LoadingView(text: "Buscando")
                    
                case .success(let data):
                    
                    VStack()
                    {
                        ForEach(data, id: \.id) { continente in
                            ContinentePainelView(continenteData: continente)
                        }
                    }
                case .failed(let error):
                    ErroView(erro: error)
                    
                default: BaseView()
                }
            }.task { await viewModel.getInfoContinentes() }
                .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task {await viewModel.getInfoContinentes()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
                .navigationBarTitle("Lista países", displayMode: .inline)
        }
    }
    
    func didDismiss()
    {
        
    }
}

