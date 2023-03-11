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
            HeaderView(nomeView: "Artigo detalhe", nomeMenu: "Voltar")
            
            VStack(alignment: .leading)
            {
                if let urlImagem = artigo.urlToImage
                {
                    AsyncImage(url: URL(string: urlImagem)) { phase in
                        switch phase
                        {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 300, maxHeight: 300)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            BaseView()
                        }
                    }
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
                if let link = URL(string: artigo.url)
                {
                    Link(artigo.url, destination: link)
                }
                Text(relativeTime)
                    .font(.caption)
                    .padding(.top, 7)
            }
            .padding()
            Spacer()
        }
        .padding([.leading, .trailing], 10)
    }
}