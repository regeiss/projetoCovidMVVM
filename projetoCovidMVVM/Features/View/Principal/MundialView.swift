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
    @State private var goToSettings = false
    @State var mundialData: MundialModel?
    
    var body: some View
    {
        NavigationStack
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
                        MundialPainelView(mundialData: data, updated: String(data.updated.getDateFromTimeStamp()))
                        Divider()
                        ScrollView
                        {
                            ContinenteListaView()
                        }
                    }
                case .failed(let error):
                    ErroView(erro: error)
                    
                default: BaseView()
                }
            }.task { await viewModel.getAllEstatisticas()}
             .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
                    { Task { await viewModel.getAllEstatisticas()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
             .navigationBarTitle("Dados COVID mundo")
             .toolbar {
                Button(role: .destructive, action: { goToSettings = true})
                 { Label("Settings", systemImage: "gearshape.fill").foregroundColor(.blue)}
             }
             .navigationDestination(isPresented: $goToSettings, destination: { AjustesView()})
        }
    }
}
