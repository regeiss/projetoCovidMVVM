//
//  AjustesView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/03/23.
//

import SwiftUI

struct AjustesView: View
{
    @State private var sheetNews: Bool = false
    @State private var ligado: Bool = false
    
    var body: some View
    {
        let version = Bundle.version + Bundle.build + Bundle.versionBuild
        
        VStack(alignment: .leading)
        {
            List
            {
                Section(header: Text("Seção1"))
                {
                    //AboutRow(title: "Love the game? share!", accessibilityTitle: "Love the game? share!")
                    SettingsRow(imageName: "square.and.arrow.up", title: "Compartilhe", addOverlay: false, showDisclosure: false)
                }
                
                Section(header: Text("Seção2"))
                {
                    SettingsRow(imageName: "rectangle.3.group.fill", title: "Onboarding", addOverlay: false)
                    SettingsRow(imageName: "newspaper", title: "Novidades", addOverlay: false).onTapGesture {
                        sheetNews = true
                    }
                    WriteReviewRow(appURL: "https://apps.apple.com/us/app/gradient-game/id1479784361", addOverlay: false)
                    TwitterRow(title: "Tweet about it", twitterAppURL: "twitter://user?screen_name=gradientsgame", twitterWebURL: "https://www.twitter.com/gradientsgame", addOverlay: false)
                    SettingsToggleRow(imageName: "gear", title: "Teste", value: $ligado, addOverlay: false)
                }
                
                Section(header: Text("Seção3"))
                {
                    AppVersionRow(version: version, addOverlay: false)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Ajustes")
            //.accentColor(.black)
            Spacer()
        }.sheet(isPresented: $sheetNews)
        {
            WhatsNew()
        }
        
    }
}

struct AjustesView_Previews: PreviewProvider {
    static var previews: some View {
        AjustesView()
    }
}
