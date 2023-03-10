//
//  ArtigoPainelExtenso.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 10/03/23.
//

import SwiftUI

struct ArtigoPainelExtenso: View
{
    var artigo: ArtigoModelElement
    var relativeTime: String
    
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
