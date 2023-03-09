//
//  ArtigoPainelCompacto.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 08/03/23.
//

import SwiftUI

struct ArtigoPainelCompacto: View
{
    var defaultLang: String = "en-US"
    var artigo: ArtigoModelElement
    var mkt: String = "en-US"
    var localeIdentifier: String { defaultLang.replacingOccurrences(of: "-", with: "_")}
     
    var relativeTime: String
    {
        let relativeDateTimeFormatter = RelativeDateTimeFormatter()
        relativeDateTimeFormatter.locale = Locale(identifier: localeIdentifier)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let safeTime = dateFormatter.date(from: artigo.publishedAt)
        {
            return relativeDateTimeFormatter.localizedString(for: safeTime, relativeTo: Date())
        }
        return artigo.publishedAt
    }
    
    var body: some View
    {
        VStack(alignment: .leading)
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
                if let safeDescription = artigo.description
                {
                    Text(safeDescription)
                        .font(.system(.subheadline, design: .serif))
                        .lineLimit(nil)
                        .padding(.top, 7)
                }
                Text(relativeTime)
                    .font(.caption)
                    .padding(.top, 7)
            }
            .padding()
        }
        .artigoPainelViewStyle()
        .padding([.leading, .trailing], 10)
    }
}
