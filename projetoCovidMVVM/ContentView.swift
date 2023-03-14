//
//  ContentView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI
import NavigationStack

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
    
    static let navigationStack = NavigationStackCompat()
    
    var body: some View
    {
        NavigationStackView(transitionType: .default, navigationStack: ContentView.navigationStack)
        {
            TabView
            {
                MundialView()
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
                ArtigoView()
                    .tabItem({
                        Image(systemName: "newspaper")
                        Text("Notícias")
                    })
            }
        }
        //.edgesIgnoringSafeArea(.top)
    }
}

