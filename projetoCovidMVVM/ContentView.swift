//
//  ContentView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI
import ConcentricOnboarding

struct ContentView: View
{
    init()
    {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color.blue.opacity(0.2))
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
//      Precisa conta desenv paga
//        AppleCloudIdentifier.fetch { (handler) in
//            switch handler {
//            case .success(let token):
//                print("CLOUD TOKEN: \(token)")
//            case .failure(let error):
//                print("ERROR: \(error)")
//            }
//        }
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
            ContinenteView()
                .tabItem({
                    Image(systemName: "globe.americas.fill")
                    Text("Continentes")
                })
            PaisListaView()
                .tabItem({
                    Image(systemName: "list.dash")
                    Text("Países")
                })
            WhatsNew()
                .tabItem({
                    Image(systemName: "chart.bar.xaxis")
                    Text("Gráficos")
                })
            OnboardingView()
                .tabItem({
                    Image(systemName: "newspaper")
                    Text("Notícias")
                })
        }
    }
}

