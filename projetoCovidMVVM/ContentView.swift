//
//  ContentView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct ContentView: View
{
    var body: some View
    {
        TabView
        {
            EstatisticasTotalView()
                .tabItem({
                    Image(systemName: "person.3.fill")
                    Text("Estatísticas")
                })
            MapaMundiView()
                .tabItem({
                    Image(systemName: "map.fill")
                    Text("Mapa")
                })
            PaisListaView()
                .tabItem({
                    Image(systemName: "list.dash")
                    Text("Países")
                })
        }
        .edgesIgnoringSafeArea(.top)
        .accentColor(Color.primary)
    }
}

