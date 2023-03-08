//
//  NoticiasView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 06/03/23.
//

import SwiftUI

struct NoticiasView: View
{
    @StateObject private var viewModel = ArtigosViewModelImpl(service: NetworkService())
    
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
                        //WorldStatsCard(worldData: data)
                        Text(String(data.title))
                    }
                default: LoadingView(text: "Erro")
                }
            }.task { await viewModel.getAllArtigos() }
            .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task { await viewModel.getAllArtigos()}}}
                        message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            .navigationBarTitle("Noticias mundo", displayMode: .automatic)
        }
    }
}
