//
//  ArtigoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 06/03/23.
//

import SwiftUI

struct ArtigoView: View
{
    @StateObject private var viewModel = ArtigosViewModelImpl(service: NetworkService())
    
    var body: some View
    {
        VStack
        {
            ArtigoHeaderView()
            
            ScrollView(.vertical)
            {
                switch viewModel.state
                {
                case .loading:
                    LoadingView(text: "Buscando")
                    
                case .success(let data):
                    
                    VStack
                    {
                        ForEach(data.articles, id: \.id) { artigo in
                            ArtigoPainelCompactoView(artigo: artigo)
                        }
                    }.padding()
                    
                case .failed(let error):
                    ErroView(erro: error)
                    
                default: BaseView()
                }
            }.task { await viewModel.getAllArtigos() }
            .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                { Task { await viewModel.getAllArtigos()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            .navigationBarTitle("Noticias mundo", displayMode: .automatic)
        }.background(LinearGradient(gradient: Gradient(colors: [Color("adaptiveBlue"),Color(.blue), Color(.systemGray)]), startPoint: .top, endPoint: .bottom))
    }
}

