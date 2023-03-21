//
//  PaisPainelExtensoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 12/03/23.
//

import SwiftUI
import MapKit

struct PaisPainelExtensoView: View
{
    @Environment(\.dismiss) var dismiss
    var pais: PaisModelElement
    var mapRegion: MKCoordinateRegion?
    var center: CLLocationCoordinate2D?
    
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
                                Text("Taxa cresc. dia")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(pais.todayCases).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Taxa cresc. 14 dias")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(pais.todayRecovered).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                            }
                            
                            HStack
                            {
                                Text("Fatalidades")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Text(String(pais.deaths).toNumberFormat())
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing)
                    {
                        Text(String((pais.cases).numberFormat()))
                            .font(.system(size: 28))
                            .fontWeight(.light)
                        Text("total")
                            .font(.system(size: 12))
                            .fontWeight(.light)
                        Text(String(pais.active).toNumberFormat())
                            .font(.system(size: 22))
                            .fontWeight(.light)
                        Text("novos casos")
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
                            Text("Mortes")
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
                            Text("Recuperados")
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
            
            HStack
            {
                if let urlImagem = pais.countryInfo.flag
                {
                    AsyncImage(url: URL(string: urlImagem)) { phase in
                        switch phase
                        {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 100, maxHeight: 50)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            BaseView()
                        }
                    }
                }
            }.padding()
            
            VStack
            {
                MapaPaisPainelDetalhe(mapRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: pais.countryInfo.lat ?? 37.334_900, longitude: pais.countryInfo.long ?? -122.009_020), latitudinalMeters: 400_000, longitudinalMeters: 400_000))
            }
        }
        .placeCardStyle()
        Spacer() 
    }
}

