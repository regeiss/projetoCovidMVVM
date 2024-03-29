//
//  PaisListaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct PaisListaView: View
{
    @StateObject private var viewModel = PaisListaViewModelImpl(service: NetworkService())
    @State private var isShowingSheet = false
    @State var searchText = ""
    @State private var paisSelecionado: PaisModelElement?
    
    var body: some View
    {
        NavigationStack
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
                            SearchBar(text: $searchText, placeholder: "Pesquisar")
                                .padding(.vertical, 5)
                            Divider()
                                .frame(height: 1)
                                .background(Color(.systemGray2))
                                .padding(.bottom, 5)
                            List
                            {
                                Section(header:
                                            HStack
                                        {
                                    CabecalhoView(title: "País",
                                                  fontSize: 14,
                                                  fontWeight: .bold)
                                    .frame(width: 130, alignment: .leading)
                                    Spacer()
                                    CabecalhoView(title: "Casos",
                                                  fontSize: 14,
                                                  fontWeight: .bold)
                                    .frame(width: 90, alignment: .trailing)
                                    CabecalhoView(title: "Mortes",
                                                  fontSize: 14,
                                                  fontWeight: .bold)
                                    .frame(width: 90, alignment: .trailing)
                                }
                                )
                                {
                                    
                                    ForEach(data.filter
                                            { self.searchText.isEmpty ? true : $0.country.lowercased().contains(self.searchText.lowercased())
                                                                }, id: \.country) { pais in
                                        LinhaDetalheView(textOne: String(pais.country),
                                                         textTwo: "\(pais.cases.numberFormat())",
                                                         textThree: "\(pais.deaths.numberFormat())",
                                                         fontSize: 14,
                                                         fontWeight: .regular,
                                                         frameWidth: 140)
                                        .onTapGesture { isShowingSheet = true
                                            paisSelecionado = pais
                                        }
                                    }
                                }
                            }.listStyle(.inset)
                        }
                    case .failed(let error):
                        ErroView(erro: error)
                        
                    default: BaseView()
                    }
                }.task { await viewModel.getListaPaises() }
                .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                        { Task {await viewModel.getListaPaises()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
                .navigationBarTitle("Lista países", displayMode: .automatic)
            }.sheet(item: $paisSelecionado, onDismiss: didDismiss)
                { paisSelecionado in  PaisPainelExtensoView(pais: paisSelecionado)}
            .navigationTitle("Lista países")
        }
    }
    
    func didDismiss()
    {
        
    }
}




