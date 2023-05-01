//
//  MundialPainelDetalheView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 13/03/23.
//

import SwiftUI

enum tipoDetalhe
{
    case casos
    case mortes
    case recuperados
}

struct MundialPainelDetalheView: View
{
    var mundialData: EstatisticasMundialModel
    var updated: String
    
    var body: some View
    {
        ScrollView
        {
            MundialPainelDetalheTipoView(covidData: mundialData, tipo: "Casos", corTitulo: "casesColor", updated: updated)
            MundialPainelDetalheTipoView(covidData: mundialData, tipo: "Mortes", corTitulo: "deathsColor", updated: updated)
            MundialPainelDetalheTipoView(covidData: mundialData, tipo: "Recuperados", corTitulo: "recoveredColor", updated: updated)
        }
    }
}

// TODO: Refatorar
struct MundialPainelDetalheTipoView: View
{
    var covidData: EstatisticasMundialModel
    var tipo: String
    var corTitulo: String
    var defaultLang: String?
    var localeIdentifier: String
    {
        defaultLang!.replacingOccurrences(of: "-", with: "_")
    }
    
    @State var updated: String = "_"
    
    @State var loadingPeriod: LoadingPeriod = LoadingPeriod.month
    @State var cumulativeOrNew: CumulativeOrNew = CumulativeOrNew.cumulative
    @State var logOrValue: LogOrValue = LogOrValue.value
    
    @State var total: String = "N/A"
    @State var new: String = "N/A"
    @State var dailyGrowth: String = "N/A"
    @State var fourteenGrowth: String = "N/A"
    
    var period: String
    {
        switch loadingPeriod
        {
        case .week: return "in the past week"
        case .month: return "in the past month"
        case .threeMonth: return "in the past three months"
        }
    }
    
    var days: Int
    {
        switch loadingPeriod
        {
        case .week: return 7
        case .month: return 30
        case .threeMonth: return 90
        }
    }
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading)
            {
                VStack(alignment: .leading)
                {
                    Text(tipo)
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(Color(corTitulo))
                    Text(updated)
                        .font(.system(size: 18, weight: .black))
                }
                .padding(.bottom, 25)
                
                HStack
                {
                    VStack
                    {
                        HStack
                        {
                            Text("Total")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(total)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        
                        Rectangle()
                            .foregroundColor(Color(corTitulo))
                            .frame(height: 2)
                    }
                    
                    VStack
                    {
                        HStack
                        {
                            Text("Novos")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(new)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        Rectangle()
                            .foregroundColor(Color(corTitulo))
                            .frame(height: 2)
                    }
                    
                }
                
                HStack
                {
                    VStack
                    {
                        HStack
                        {
                            Text("Cresc. diário")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(dailyGrowth)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        
                        Rectangle()
                            .foregroundColor(Color(corTitulo))
                            .frame(height: 2)
                    }
                    
                    VStack
                    {
                        HStack
                        {
                            Text("Cresc. em 14 dias")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(fourteenGrowth)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        
                        Rectangle()
                            .foregroundColor(Color(corTitulo))
                            .frame(height: 2)
                    }
                }
                VStack
                {
                    GraficoMundialView(loadingPeriod: $loadingPeriod, dataCategory: .constant(.cases), cumulativeOrNew: $cumulativeOrNew, logOrValue: $logOrValue,
                                       covidData: covidData)
                    .frame(height: 130)
                }
                
                HStack
                {
                    Picker(selection: $cumulativeOrNew, label: Text("X-Axis"))
                    {
                        Text("Novo").tag(CumulativeOrNew.new)
                        Text("Cumulativo").tag(CumulativeOrNew.cumulative)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker(selection: $logOrValue, label: Text("Y-Axis"))
                    {
                        Text("Valor").tag(LogOrValue.value)
                        Text("Log").tag(LogOrValue.log)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.bottom, 8)
                
                Picker(selection: $loadingPeriod, label: Text("Período sel."))
                {
                    Text("1 semana").tag(LoadingPeriod.week)
                    Text("1 mês").tag(LoadingPeriod.month)
                    Text("3 meses").tag(LoadingPeriod.threeMonth)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.vertical)
            
            Divider()
            
            HStack
            {
                Text("Atualizado em:")
                Text(updated)
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.bottom, 20)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBackground),Color(.systemBackground), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom))
        .onAppear()
        {
            total = covidData.cases.numberFormat()
            new = covidData.todayCases.numberFormat()
            dailyGrowth = "N/A"
            fourteenGrowth = "N/A"
        }
    }
    //    func getFatality(offset: Int = 1) -> String {
    //        let fatality = Float (self.getTodayDeaths(offset: offset)) / Float (self.getTodayCases(offset: offset)) * Float (100)
    //        return String(format: "%.2f", fatality) + "%"
    //    }
    
    //
//        func getTodayCases(offset: Int) -> String
//        {
//            let date = self.covidData[active].first(where: {$0 == ""})
//            return date
//        }
//
//        func getDailyGrowthRate(offset: Int)  -> String
//        {
//            let dailyGrowthRate = Float (self.getTodayNewCases(offset: offset)) / Float(self.getTodayNewCases(offset: offset+1))  * Float (100)
//            return String(format: "%.2f", dailyGrowthRate) + "%"
//        }
    //
    //    func get14DaysGrowthRate(offset: Int = 1) -> String {
    //        if CovidDataModel.dataLength-offset-26 > 0 {
    //            let growth = self.cases![CovidDataModel.dataLength-(offset+13)...CovidDataModel.dataLength-offset].reduce(0, +)
    //            let base = self.cases![CovidDataModel.dataLength-(offset+28)...CovidDataModel.dataLength-(offset+15)].reduce(0, +)
    //            let fourteenDaysGrowthRate = Float (growth) / Float(base)  * Float (100)
    //            return String(format: "%.2f", fourteenDaysGrowthRate) + "%"
    //        }
    //        return "N/A"
    //    }
}
