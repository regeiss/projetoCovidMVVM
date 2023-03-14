//
//  PaisPainelExtensoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 12/03/23.
//

import SwiftUI

struct PaisPainelExtensoView: View
{
    @Environment(\.dismiss) var dismiss
    var pais: PaisModelElement
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            HStack
            {
                Spacer()
                Image(systemName: "xmark.circle")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .onTapGesture
                    { dismiss()}
            }.padding()
            
            VStack(alignment: .leading)
            {
                HStack(alignment: .top)
                {
                    VStack(alignment: .leading)
                    {
                        
                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text(pais.country)
                                .font(.system(size: 20))
                                .fontWeight(.regular)
                                .padding(.bottom, 6)
                            
                            HStack
                            {
                                Text("Daily Growth Rate")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(pais.activePerOneMillion))
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("14 Days Growth Rate")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(pais.casesPerOneMillion))
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Fatality")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(pais.deaths))
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing)
                    {
                        Text("\(pais.cases)")
                            .font(.system(size: 28))
                            .fontWeight(.light)
                        Text("in total")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                        Text("\(pais.casesPerOneMillion)")
                            .font(.system(size: 22))
                            .fontWeight(.light)
                        Text("new cases")
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
                            Text("Cases")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            Spacer()
                            Text("\(pais.cases)")
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
                            Text("Deaths")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            Spacer()
                            Text("\(pais.deaths)")
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
                            Text("Recovered")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .lineLimit(1)
                            Spacer()
                            
                            Text("\(pais.recovered)")
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
        }
        .placeCardStyle()
        Spacer() 
    }
}

