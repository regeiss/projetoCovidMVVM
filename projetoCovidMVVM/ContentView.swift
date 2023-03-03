//
//  ContentView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct ContentView: View
{

    UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
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
            GraficoView()
                .tabItem({
                    Image(systemName: "chart.bar.xaxis")
                    Text("Gráficos")
                })
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.orange.opacity(0.2))
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .edgesIgnoringSafeArea(.top)
    }
}

