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
    @State private var searchText: String = ""
    
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
                        Text(String(data[1].population))
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
            .searchable(text: $searchText, placement: .automatic, prompt: Text("?????"))
        //.refreshable { Task {await vm.getAllQuotes()}}  //?
      }
}

