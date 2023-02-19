//
//  PaisListaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct PaisListaView: View
{
    @State private var searchText: String = ""
    
    var body: some View
    {
        NavigationView
        {
            Text("Lista Pais")
        }.searchable(text: $searchText, placement: .automatic, prompt: Text("?????"))
    }
}

