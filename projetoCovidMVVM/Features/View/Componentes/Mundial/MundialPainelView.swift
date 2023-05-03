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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.data, order: .forward)], predicate: NSPredicate(format: "tipo == %@", "casos"))
    private var seriesCasos: FetchedResults<SeriesHistoricas>
    
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
                            
                            TaxasView(texto: "Taxa cresc. diária", valor: String(mundialData.cases))
                            TaxasView(texto: "Taxa cresc. 14 dias", valor: String(mundialData.cases))
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
        let data = Date()
        let casosHoje = self.seriesCasos[data]
        
        let dailyGrowthRate = Float (self.seriesCasos.index(0, offsetBy: 1)) / Float(self.seriesCasos.index(0, offsetBy: 2))  * Float (100)
    }
}

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
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
