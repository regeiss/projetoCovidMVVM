//
//  MundialPainelView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 13/03/23.
//

import SwiftUI

struct MundialPainelView: View
{
    var mundialData: EstatisticasMundialModel
    var updated: String
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading)
            {
                HStack(alignment: .top)
                {
                    VStack(alignment: .leading)
                    {
                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("Mundial")
                                .font(.system(size: 20))
                                .fontWeight(.regular)
                                .padding(.bottom, 6)
                            
                            HStack
                            {
                                Text("Taxa cresc. diária")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(mundialData.cases).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Taxa cresc. 14 dias")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(mundialData.deaths).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Fatalidades")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(mundialData.deaths).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing)
                    {
                        Text("\(mundialData.cases)")
                            .font(.system(size: 28))
                            .fontWeight(.light)
                        Text("total")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                        Text("\(mundialData.active)")
                            .font(.system(size: 22))
                            .fontWeight(.light)
                        Text("ativos")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                    }
                }
                .padding(.bottom, 3)
                
                HStack
                {
                    RodapeGeral(texto: "Casos", qtd: mundialData.cases, cor: "casesColor")
                    RodapeGeral(texto: "Mortes", qtd: mundialData.deaths, cor: "deathsColor")
                    RodapeGeral(texto: "Recuperados", qtd: mundialData.recovered, cor: "recoveredColor")
                }
            }
            .padding()
            
            Text(updated)
                .font(.footnote)
                .padding()
            
        }.placeCardStyle()
    }
}

struct RodapeGeral: View
{
    var texto: String
    var qtd: Int
    var cor: String
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                Text(texto)
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .lineLimit(1)
                Spacer()
                Text("\(qtd)")
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .lineLimit(1)
            }
            Rectangle()
                .foregroundColor(Color(cor))
                .frame(height: 2)
        }
    }
}
