//
//  PaisListaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct PaisListaView: View
{
    @StateObject private var vm = PaisListaViewModelImpl(service: NetworkService())
    
    @State private var searchText: String = ""
    @State var isSearching = false
    
    var body: some View
    {
        NavigationView
        {
            Text("Lista Pais")
        }.searchable(text: $searchText, placement: .automatic, prompt: Text("?????"))
    }
}

