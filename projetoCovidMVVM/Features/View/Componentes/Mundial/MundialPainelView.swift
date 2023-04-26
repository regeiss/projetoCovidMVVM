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
                                Text(String(mundialData.activePerOneMillion).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Taxa cresc. 14 dias")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(mundialData.casesPerOneMillion).toNumberFormat())
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
                    VStack
                    {
                        HStack
                        {
                            Text("Casos")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            Spacer()
                            Text("\(mundialData.cases)")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                        }
                        Rectangle()
                            .foregroundColor(Color("casesColor"))
                            .frame(height: 2)
                    }
                    
                    VStack
                    {
                        HStack
                        {
                            Text("Mortes")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            Spacer()
                            Text("\(mundialData.deaths)")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                        }
                        Rectangle()
                            .foregroundColor(Color("deathsColor"))
                            .frame(height: 2)
                    }
                    
                    VStack
                    {
                        HStack
                        {
                            Text("Recuperados")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            Spacer()
                            
                            Text("\(mundialData.recovered)")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            
                        }
                        Rectangle()
                            .foregroundColor(Color("recoveredColor"))
                            .frame(height: 2)
                    }
                }
            }
            .padding()
            Text(updated).font(.footnote)
                .padding()
        }.placeCardStyle()
    }
}
