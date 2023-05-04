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
    @StateObject private var viewModel90dias = SeriesHistoricasViewModelImpl(service: NetworkService())
    
    //    @State var mundialData: EstatisticasMundialModel?
    //    @State var series90Data: MundialSeriesModel?
    @State private var goToSettings = false
    
    var body: some View
    {
        NavigationStack
        {
            VStack
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
                            MundialPainelDetalheView(mundialData: data, updated: String(data.updated.getDateFromTimeStamp()))
                        }
                    }
                case .failed(let error):
                    ErroView(erro: error)
                    
                default: BaseView()
                }
                
            }.navigationBarTitle("Dados COVID mundo")
                .toolbar { Button(role: .destructive, action: { goToSettings = true})
                    { Label("Settings", systemImage: "gearshape.fill").foregroundColor(.blue)}
                }.navigationDestination(isPresented: $goToSettings, destination: { AjustesView()})
        }
        .task { await viewModel.getAllEstatisticas()
                 await viewModel90dias.getSeries90Dias()}
        .alert("Error", isPresented: ($viewModel.hasError), presenting: viewModel.state) { detail in Button("Retry", role: .destructive)
            { Task { await viewModel.getAllEstatisticas()}}} message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            
    }
}
