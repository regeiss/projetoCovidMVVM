//
//  EstatisticasTotalView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct EstatisticasTotalView: View
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
                        WorldStatsCard(worldData: data)
                        Text(String(data.updated.getDateFromTimeStamp()))
                    }
//                    Spacer()
//                    ScrollView(.horizontal, showsIndicators: false)
//                    {
//                        HStack(alignment: .top, spacing: 15)
//                        {
//                            ForEach(vm.data, id: \.countryInfo._id) { country in
//                                CartaoEstatisticasPais(countryData: country)
//                                   // .onTapGesture { vm.mundial= country }
//                            }
//                        }
//                        .padding(.leading, 15)
//                    }
                default: LoadingView(text: "Erro")
                }
            }.task { await viewModel.getAllEstatisticas() }
             .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task { await viewModel.getAllEstatisticas()}}}
                    message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
             .navigationBarTitle("Estatisticas mundo", displayMode: .automatic)
        }
    }
}

