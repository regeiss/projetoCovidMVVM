//
//  AjustesView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/03/23.
//

import SwiftUI
import SwiftVB

struct AjustesView: View
{
    var body: some View
    {
        @State var ligado: Bool = false
        let version = Bundle.version + Bundle.build + Bundle.versionBuild
        
        NavigationView
        {
            List
            {
                Section(header: Text("mm"))
                {
                    //AboutRow(title: "Love the game? share!", accessibilityTitle: "Love the game? share!")
                    SettingsRow(imageName: "square.and.arrow.up", title: "Share1", addOverlay: false)
//                    SettingsActionRow(imageName: "square.and.arrow.up", title: "Share", addOverlay: false)
//                    {
//                        // Add share action here
//                    }
                }
                
                Section
                {
                    SettingsNavigationRow(imageName: "rectangle.3.group.fill", title: "Onboarding", addOverlay: false, destination: OnboardingView())
                    SettingsNavigationRow(imageName: "newspaper", title: "What's new", addOverlay: false, destination: WhatsNew())
                    WriteReviewRow(appURL: "https://apps.apple.com/us/app/gradient-game/id1479784361", addOverlay: false)
                    TwitterRow(title: "Tweet about it", twitterAppURL: "twitter://user?screen_name=gradientsgame", twitterWebURL: "https://www.twitter.com/gradientsgame", addOverlay: false)
                    SettingsToggleRow(imageName: "gear", title: "Teste", value: $ligado, addOverlay: false)
                }
                
                Section
                {
                    AppVersionRow(version: version, addOverlay: false)
                }
            }
            .listStyle(.insetGrouped)
            .accentColor(.black)
            .navigationTitle("Ajustes")
        }
    }
}

struct AjustesView_Previews: PreviewProvider {
    static var previews: some View {
        AjustesView()
    }
}
