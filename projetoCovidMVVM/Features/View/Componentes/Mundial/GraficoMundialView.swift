//
//  GraficoMundialView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 20/03/23.
//

import SwiftUI
import Charts

struct GraficoMundialView: View
{
    @Binding var loadingPeriod: LoadingPeriod
    @Binding var dataCategory: DataCategory
    @Binding var cumulativeOrNew: CumulativeOrNew
    @Binding var logOrValue: LogOrValue
    
    var covidData: EstatisticasMundialModel
    
    var title: String
    {
        switch dataCategory
        {
        case .cases: return "Cases"
        case .deaths: return "Deaths"
        case .recovered: return "Recovered"
        }
    }
    
    var barColor: Color
    {
        switch dataCategory
        {
        case .cases: return Color(red: 233/255.0, green: 71/255.0, blue: 93/255.0)
        case .deaths: return Color(red: 240/255.0, green: 145/255.0, blue: 53/255.0)
        case .recovered: return Color(red: 118/255.0, green: 189/255.0, blue: 144/255.0)
        }
    }
    
    var body: some View
    {
        Chart
        {
            AreaMark(
                x: .value("Mount", "jan/22"),
                y: .value("Value", 5)
            )
            AreaMark(
                x: .value("Mount", "fev/22"),
                y: .value("Value", 4)
            )
            AreaMark(
                x: .value("Mount", "mar/22"),
                y: .value("Value", 7)
            )
        }
    }
}



