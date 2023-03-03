//
//  GraficoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/02/23.
//

import SwiftUI
import Charts

struct GraficoView: View
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
                    Chart
                    {
                        BarMark(
                            x: .value("Mount", "jan/22"),
                            y: .value("Value", 5)
                        )
                        BarMark(
                            x: .value("Mount", "fev/22"),
                            y: .value("Value", 4)
                        )
                        BarMark(
                            x: .value("Mount", "mar/22"),
                            y: .value("Value", 7)
                        )
                    }
                    .frame(height: 250)
                    
                default: LoadingView(text: "Erro")
                }
            }.task { await viewModel.getInfoContinentes() }
                .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task {await viewModel.getInfoContinentes()}}}
                      message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
                .navigationBarTitle("Lista países", displayMode: .automatic)
        }
    }
}
