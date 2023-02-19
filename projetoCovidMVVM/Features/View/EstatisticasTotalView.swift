//
//  EstatisticasTotalView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct EstatisticasTotalView: View
{
    @StateObject private var vm = MundialViewModelImpl(service: NetworkServiceImpl())
  //  
    
    var body: some View
    {
        NavigationView
        {
            Group
            {
                switch vm.state
                {
                    case .loading:
                        LoadingView(text: "Fetching data...")
                    case .success(let data):
                    VStack
                    {
                        Text(String(data.population.numberFormat()))
                        Text(String(data.updated))
                        Text(String(data.cases).toQuilometrosFormat())
                        
                    }
//                    List
//                    {
//                        ForEach(data, id: \.id)
//                        { item in
//                            HStack
//                            {
//                                Image(systemName: "character.bubble.fill")
//                                    .font(.system(size: 16, weight: .black))
//                                Text(String(item.population))
//                            }}
//                    }
                default:
                    Text("sssss")
                }
                
            }
        }
        .alert("Error",
               isPresented: $vm.hasError, presenting: vm.state) { detail in Button("Retry", role: .destructive)
            { Task {await vm.getAllEstatisticas()}}}
    message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            .task
        { await vm.getAllEstatisticas()}
            .navigationTitle("Postagens")
            .navigationBarTitleDisplayMode(.large)
            .redacted(reason: vm.carregando ? .placeholder : [])
            .allowsHitTesting(vm.carregando)
           // 
        //.refreshable { Task {await vm.getAllQuotes()}}  //?
      }
}

