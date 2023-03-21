//
//  ArtigoHeaderView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 10/03/23.
//

import SwiftUI

struct ArtigoHeaderView: View
{
    @State private var translate: Bool = false
    @State var noResults: Bool = false
    var translateManager: NewsListTranslater{ NewsListTranslater() }
    var placeName: String = "Brasil"
    var translatable: Bool = false
    var localeIdentifier: String = "en_US"
    var today: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        return dateFormatter.string(from: Date())
    }
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading, spacing:0)
            {
                HStack
                {
                    Image(systemName: "mappin")
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(.white)
                        .frame(width: 8)
                    Text(placeName)
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(.white)
                }
                HStack
                {
                    Text("Notícias")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
                    Spacer()
                    Menu(content: {
                        if translatable {
                            if translate {
                                Button(action: {
                                    translateManager.untranslate()
                                    translate = false
                                }) {
                                    Label(
                                        title: { Text("Show Origin") },
                                        icon: { Image(systemName: "doc") }
                                    )
                                }
                            } else {
                                Button(action: {
                                    translateManager.archiveDataAndTranslate()
                                    translate = true
                                }, label: {
                                    Label(
                                        title: { Text("Translate") },
                                        icon: { Image(systemName: "doc.plaintext") }
                                    )
                                })
                            }
                        } else {
                            Text("Traduzir")
                                .foregroundColor(Color(.systemGray))
                        }
                    }) {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                Text(today)
                    .font(.system(size: 18, weight: .black))
                    .foregroundColor(.white)
            }
        }.background(Color("adaptiveBlue"))
            .padding()
    }
}
