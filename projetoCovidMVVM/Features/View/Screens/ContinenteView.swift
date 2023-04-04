//
//  ContinenteView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct ContinenteView: View
{
    var body: some View
    {
        NavigationStack
        {
            ScrollView
            {
                ContinenteListaView()
            }.navigationTitle("Mapas")
        }
    }
}

