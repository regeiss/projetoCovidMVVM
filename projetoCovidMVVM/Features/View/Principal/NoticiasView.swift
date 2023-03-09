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
                        ForEach(data.articles, id: \.id) { artigo in
//                            Group{
//                                LinhaDetalheView(textOne: String(artigo.author ?? ""),
//                                                 textTwo: "\(artigo.title)",
//                                                 textThree: "\(artigo.description)",
//                                                 fontSize: 14,
//                                                 fontWeight: .regular,
//                                                 frameWidth: 140)
//                                //.foregroundColor(Color(.black))
//                                //.onTapGesture { vm.selectedCountry = country }
//                            }
                            ArtigoPainelCompacto(artigo: artigo)
                        }
//                        List(data.articles)
//                        { artigo in
//                            LinhaDetalheView(textOne: String(artigo.author),
//                                             textTwo: "\(artigo.title)",
//                                             textThree: "\(artigo.description)",
//                                             fontSize: 14,
//                                             fontWeight: .regular,
//                                             frameWidth: 140)
//                        }
                        Text(data.status)
                    }
                    
                case .failed(let error):
                    ErroView(erro: error)
                    
                default: BaseView()
                }
            }.task { await viewModel.getAllArtigos() }
            .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task { await viewModel.getAllArtigos()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            .navigationBarTitle("Noticias mundo", displayMode: .automatic)
        }
    }
}
