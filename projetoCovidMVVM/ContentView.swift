//
//  ContentView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct ContentView: View
{
    init()
    {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color.blue.opacity(0.2))
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View
    {
        TabView
        {
            MundialView()
                .tabItem({
                    Image(systemName: "person.3.fill")
                    Text("Estatísticas")
                })
            ListaContinenteView()
                .tabItem({
                    Image(systemName: "globe.americas.fill")
                    Text("Continentes")
                })
            PaisListaView()
                .tabItem({
                    Image(systemName: "list.dash")
                    Text("Países")
                })
            GraficoView()
                .tabItem({
                    Image(systemName: "chart.bar.xaxis")
                    Text("Gráficos")
                })
            ArtigoView()
                .tabItem({
                    Image(systemName: "newspaper")
                    Text("Notícias")
                })
        }
    }
}

