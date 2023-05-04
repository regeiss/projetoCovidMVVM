//
//  MundialPainelView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 13/03/23.
//

import CoreData
import SwiftUI

struct MundialPainelView: View
{
    @FetchRequest(sortDescriptors: [SortDescriptor(\.data, order: .reverse)], predicate: NSPredicate(format: "tipo == %@", "casos"))
    private var seriesCasos: FetchedResults<SeriesHistoricas>
    
    var mundialData: EstatisticasMundialModel
    var updated: String
    @State var dailyGrowthRate: Float = 0.0
    @State var dailyGrowthRate14: Float = 0.0
    
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
                            
                            TaxasCrescimentoView(texto: "Taxa cresc. diária", valor: String(format: "%.2f", dailyGrowthRate))
                            TaxasCrescimentoView(texto: "Taxa cresc. 14 dias", valor: String(format: "%.2f", dailyGrowthRate14))
                            TaxasView(texto: "Fatalidades", valor: String(mundialData.cases))
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
            .onAppear(){ AjustaSeries() }
            
            Text(updated)
                .font(.footnote)
                .padding()
            
        }.placeCardStyle()
    }
    
    func AjustaSeries()
    {
        if self.seriesCasos.count > 0
        {
            let casosHoje = self.seriesCasos.first?.qtd ?? 0
            
            let casosOntemIndex = self.seriesCasos.index(0, offsetBy: 1)
            let casosOntem = self.seriesCasos[casosOntemIndex].qtd
            
            let casos14DiasIndex = self.seriesCasos.index(0, offsetBy: 15)
            let casos14Dias = self.seriesCasos[casos14DiasIndex].qtd
            
//            let casos30DiasIndex = self.seriesCasos.index(0, offsetBy: 59)
//            let casos30Dias = self.seriesCasos[casos30DiasIndex].qtd
//
//            let casos90dias = self.seriesCasos.last?.qtd ?? 0
            
            dailyGrowthRate = (Float (casosOntem) / Float(casosHoje))  //* Float (100)
            dailyGrowthRate14 = (Float (casos14Dias) / Float(casosHoje))  //* Float (100)
            print(String(casos14Dias))
        }
        else
        {
            print ("Casos igual a zero")
            dailyGrowthRate = 0.0
        }
    }
}

struct TaxasView: View
{
    var texto: String
    var valor: String
    
    var body: some View
    {
        HStack
        {
            Text(texto)
                .font(.system(size: 14))
                .fontWeight(.light)
            Text(valor.toNumberFormat())
                .font(.system(size: 14))
                .fontWeight(.regular)
        }
    }
}

struct TaxasCrescimentoView: View
{
    var texto: String
    var valor: String
    
    var body: some View
    {
        HStack
        {
            Text(texto)
                .font(.system(size: 14))
                .fontWeight(.light)
            Text(valor)
                .font(.system(size: 14))
                .fontWeight(.regular)
        }
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
