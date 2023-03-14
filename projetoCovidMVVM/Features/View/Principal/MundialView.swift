//
//  MundialView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct MundialView: View
{
    @StateObject private var viewModel = MundialViewModelImpl(service: NetworkService())
    
    var body: some View
    {
        NavigationView
        {
            Group
            {
                switch viewModel.state
                {
                case .loading:
                    LoadingView(text: "Buscando")
                    
                case .success(let data):
                    
                    VStack
                    {
                        MundialPainel(worldData: data)
                        Text(String(data.updated.getDateFromTimeStamp()))
                    }
                    
                case .failed(let error):
                    ErroView(erro: error)
                    
                default: BaseView()
                }
            }.task { await viewModel.getAllEstatisticas() }
             .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task { await viewModel.getAllEstatisticas()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
             .navigationBarTitle("Estatisticas mundo", displayMode: .automatic)
        }
    }
}

