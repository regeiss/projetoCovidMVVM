//
//  ContinentePainelExtensoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/03/23.
//

import SwiftUI

struct ContinentePainelView: View
{
    @State private var isShowingSheet = false
    var continenteData: ContinentElement
    
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
                            Text(String(continenteData.continent))
                                .font(.system(size: 20))
                                .fontWeight(.regular)
                                .padding(.bottom, 6)
                            
                            HStack
                            {
                                Text("Taxa cresc. diária")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(continenteData.cases).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Taxa cresc. 14 dias")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(continenteData.casesPerOneMillion).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Fatalidades")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(continenteData.deaths).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing)
                    {
                        Text("\(continenteData.cases)")
                            .font(.system(size: 28))
                            .fontWeight(.light)
                        Text("total")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                        Text("\(continenteData.active)")
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
                            Text("\(continenteData.cases)")
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
                            Text("\(continenteData.deaths)")
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
                            
                            Text("\(continenteData.recovered)")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            
                        }
                        Rectangle()
                            .foregroundColor(Color("recoveredColor"))
                            .frame(height: 2)
                    }
                }
            }.padding()
                .onTapGesture {
                    isShowingSheet = true
                    
                    
                }
                .placeCardStyle()
                .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss)
            { ContinentePainelDetalheView(nome: continenteData.id)}
        }
    }
    
    func didDismiss()
    {
        
    }
}


