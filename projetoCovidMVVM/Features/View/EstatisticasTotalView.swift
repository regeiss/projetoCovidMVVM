//
//  EstatisticasTotalView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//
import SwiftUI

struct EstatisticasTotalView: View
{
    @StateObject private var vm = MundialViewModelImpl(service: NetworkService())
    
    var body: some View
    {
        NavigationView
        {
            Group
            {
                switch vm.state
                {
                case .loading:
                    LoadingView(text: "Buscando")
                    
                case .success(let data):
                    
                    VStack
                    {
                        Text(String(data.population.numberFormat()))
                        Text(String(data.updated.getDateFromTimeStamp()))
                        Text(String(data.cases.numberFormat()))
                        
                    }
                default: LoadingView(text: "Erro")
                }
            }.task { await vm.getAllEstatisticas() }
                .alert("Error", isPresented: $vm.hasError, presenting: vm.state) { detail in Button("Retry", role: .destructive)
                                    { Task {await vm.getAllEstatisticas()}}}
                                message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
        }
    }
}

