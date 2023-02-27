//
//  Formas.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 26/02/23.
//

import SwiftUI
        
struct WorldStatsCard: View
{
    var worldData: MundialModel
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            Text("Estatísticas mundo")
                .font(.system(.largeTitle, design: .serif))
                .fontWeight(.black)
                .shadow(color: .secondary, radius: 1, x: 0.7, y: 0.7)
            
            ZStack
            {
                VStack(spacing: 20)
                {
                    Text("População total: \(worldData.population.numberFormat())")
                        .font(.system(size: 17, design: .serif))
                        .fontWeight(.light)
                        .shadow(color: Color(.darkGray), radius: 1, x: 0.7, y: 0.7)
                        .foregroundColor(Color(.label))
                        .padding(.top, 5)
                    
                    VStack(alignment: .center, spacing: 20)
                    {
                        HStack()
                        {
                            CartaoEstatisticasMundial(title: "Casos", subTitle: worldData.cases.numberFormat())
                                .padding(.leading, 5)
                            Spacer()
                            CartaoEstatisticasMundial(title: "Mortes", subTitle: worldData.deaths.numberFormat())
                                .padding(.trailing, 5)
                        }
                        
                        HStack()
                        {
                            CartaoEstatisticasMundial(title: "Ativos", subTitle: worldData.active.numberFormat())
                                .padding(.leading, 5)
                            Spacer()
                            CartaoEstatisticasMundial(title: "Recuperados", subTitle: worldData.recovered.numberFormat())
                                .padding(.trailing, 5)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .background(Color(.systemGray))
            .cornerRadius(9)
            .padding(.horizontal, 8)
        }
    }
}

struct CartaoEstatisticasMundial: View
{
    let title: String
    let subTitle: String
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 6)
        {
            CabecalhoView(title: title, fontSize: 28, fontWeight: .bold)
            CabecalhoView(title: subTitle, fontSize: 13, fontWeight: .medium)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(width: 160, height: 80)
        .background(Color(.systemGray3))
        .cornerRadius(8)
        .shadow(color: Color(.darkGray), radius: 3, x: 2, y: 2)
    }
}

struct CartaoEstatisticasPais: View
{
    var countryData: PaisModel

    var body: some View
    {
        ZStack
        {
            VStack()
            {
                HStack
                {
                    Image(countryData.country.lowercased())
                        .resizable()
                        .frame(width: 130, height: 130, alignment: .center)
                        .shadow(color: Color(.darkGray), radius: 1, x: 2, y: 2)
                    Spacer()
                    VStack {
                        Text(countryData.country)
                            .font(.system(.title2, design: .serif))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.darkText))
                            .padding(5)
                        Text("Population\n" + "\(countryData.population.numberFormat())")
                            .font(.system(size: 17, design: .serif))
                            .fontWeight(.light)
                            .foregroundColor(Color(.label))
                    }
                    .shadow(color: Color(.darkGray), radius: 0.5, x: 0.3, y: 0.3)
                    .padding(.trailing, 15)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                }
                .padding(.horizontal, 8)
                VStack(alignment: .center, spacing: 20)
                {
                    HStack()
                    {
                        CartaoEstatisticasMundial(title: "Casos", subTitle: countryData.cases.numberFormat())
                            .padding(.leading, 5)
                        Spacer()
                        CartaoEstatisticasMundial(title: "Mortes", subTitle: countryData.deaths.numberFormat())
                            .padding(.trailing, 5)
                    }
                    
                    HStack()
                    {
                        CartaoEstatisticasMundial(title: "Ativos", subTitle: countryData.active.numberFormat())
                            .padding(.leading, 5)
                        Spacer()
                        CartaoEstatisticasMundial(title: "Recuperados", subTitle: countryData.recovered.numberFormat())
                            .padding(.trailing, 5)
                    }
                }
                .padding(.top, 5)
            }
        }
        .frame(width: 340, height: 340, alignment: .center)
        .background(Color(.systemGray))
        .cornerRadius(13)
    }
}
