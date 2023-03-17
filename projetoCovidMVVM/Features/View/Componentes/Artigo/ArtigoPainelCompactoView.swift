//
//  ArtigoPainelCompactoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 08/03/23.
//

import SwiftUI

struct ArtigoPainelCompactoView: View
{
    @State private var isShowingSheet = false
    @State private var artigoSelecionado: ArtigoModelElement?
    
    var artigo: ArtigoModelElement
    var defaultLang: String = "pt_BR"
    
    var relativeTime: String
    {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.locale = Locale(identifier: "pt_BR")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let safeTime = dateFormatter.date(from: artigo.publishedAt)
        {
            return relativeDateTimeFormatter.localizedString(for: safeTime, relativeTo: Date.now)
        }
        return artigo.publishedAt
    }
    
    var body: some View
    {
        VStack
        {
            VStack(alignment: .leading)
            {
                HStack
                {
                    Spacer()
                }
                
                Text(artigo.source.name)
                    .font(.footnote)
                
                Text(artigo.title)
                    .font(.system(.headline, design: .serif))
                    .fontWeight(.bold)
                    .lineLimit(nil)
                    .padding(.top, 4)
                    .onTapGesture {
                        isShowingSheet = true
                        artigoSelecionado = artigo
                    }
                Text(relativeTime)
                    .font(.caption)
                    .padding(.top, 7)
            }
            .padding()
            .artigoPainelViewStyle()
            
        }.sheet(isPresented: $isShowingSheet, onDismiss: didDismiss)
        { ArtigoPainelExtensoView(artigo: artigo, relativeTime: relativeTime)}
    }
    
    func didDismiss()
    {
        
    }
}
