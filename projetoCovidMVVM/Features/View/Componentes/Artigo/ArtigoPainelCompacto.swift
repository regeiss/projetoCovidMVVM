//
//  ArtigoPainelCompacto.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 08/03/23.
//

import SwiftUI

struct ArtigoPainelCompacto: View
{
    let router = MyRouter.shared
    var defaultLang: String = "en_US"
    var artigo: ArtigoModelElement
    var relativeTime: String
    {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.locale = Locale(identifier: "en_US")
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
                    ArtigoPainelExtenso(artigo: artigo, relativeTime: relativeTime)
                }
            Text(relativeTime)
                .font(.caption)
                .padding(.top, 7)
        }.padding()
            .artigoPainelViewStyle()
    }
    
    func ArtigoPainelExtenso(artigo: ArtigoModelElement, relativeTime: String)
    {
        router.toArtigoPainelExtenso(artigo: artigo, relativeTime: relativeTime)
    }
}
