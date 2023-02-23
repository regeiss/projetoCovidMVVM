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
        VStack()
        {
            HStack
            {
                Image(systemName: "line.horizontal.3").foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.leading])
                
                Text("COVID-19").foregroundColor(.blue).font(.system(.title3, design: .rounded))
                Spacer()
                Text("N/A")
                Text("N/S")
                Spacer()
                Image(systemName: "car.2").foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.trailing])
            }
        }

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
                        Text(String(data.updated.getDateFromTimeStamp))
                        Text(String(data.cases.numberFormat()))
                        
                    }

                default: EmptyView()
            }
        }.task { await vm.getAllEstatisticas() }
        .alert("Error", isPresented: $vm.hasError, presenting: vm.state) { detail in Button("Retry", role: .destructive)
            { Task {await vm.getAllEstatisticas()}}}
                message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
    }
 
}


