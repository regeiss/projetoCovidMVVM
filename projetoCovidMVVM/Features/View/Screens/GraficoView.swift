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
                        
                        Chart(data)
                        {
                            BarMark(
                                x: .value("Nome", $0.continent),
                                y: .value("Mortes", $0.deaths)
                            )
                            .foregroundStyle(by: .value("Nome", $0.continent))
                        }
                        .frame(height: 350)
                        .padding(.leading, 10)
                        
                    case .failed(let error):
                        ErroView(erro: error)
                        
                    default: BaseView()
                    }
                }.task { await viewModel.getInfoContinentes() }
                    .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                        { Task {await viewModel.getInfoContinentes()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            }.navigationTitle("Gráficos")
        }
    }
}
