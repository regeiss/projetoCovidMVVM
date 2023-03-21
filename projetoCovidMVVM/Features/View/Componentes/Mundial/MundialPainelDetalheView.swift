//
//  MundialPainelDetalheView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 13/03/23.
//

import SwiftUI

struct MundialPainelDetalheView: View
{
    @Environment(\.dismiss) var dismiss
    var mundialData: MundialModel
    var updated: String
    
    var body: some View
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
        
        ScrollView{
        MundialPainelDetalheCasosView(covidData: mundialData, updated: updated)
            MundialPainelDetalheMortesView(covidData: mundialData, updated: updated)
        }
    }
}

struct MundialPainelDetalheCasosView: View
{
    var covidData: MundialModel
    var defaultLang: String?
    var localeIdentifier: String {
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
    
    var period: String {
        switch loadingPeriod {
        case .week: return "in the past week"
        case .month: return "in the past month"
        case .threeMonth: return "in the past three months"
        }
    }
    
    var days: Int {
        switch loadingPeriod {
        case .week: return 7
        case .month: return 30
        case .threeMonth: return 90
        }
    }
    
//    func updateView(num: Double?=nil, day: Double?=nil)
//    {
//        if let _ = num, let safe_day = day {
//            let modifiedDate = Calendar.current.date(byAdding: .day, value: -days + Int (safe_day), to: Date())!
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .none
//            dateFormatter.locale = Locale(identifier: localeIdentifier)
//            updated = dateFormatter.string(from: modifiedDate)
//
//            total = String(covidData.getTodayCases(offset: days-Int(safe_day)))
//            new = String(covidData.getTodayNewCases(offset: days-Int(safe_day)))
//            dailyGrowth = covidData.getDailyGrowthRate(offset: days-Int(safe_day))
//            fourteenGrowth = covidData.get14DaysGrowthRate(offset: days-Int(safe_day))
//            return
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        dateFormatter.locale = Locale(identifier: localeIdentifier)
//        updated = dateFormatter.string(from: Date())
//
//        total = String(covidData.getTodayCases())
//        new = String(covidData.getTodayNewCases())
//        dailyGrowth = covidData.getDailyGrowthRate()
//        fourteenGrowth = covidData.get14DaysGrowthRate()
//    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Casos")
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(Color("casesColor"))
                    //                    Divider()
                    //                        .padding(.vertical, 3)
                    Text(updated)
                        .font(.system(size: 18, weight: .black))
                    //                        .foregroundColor(Color("casesColor"))
                    //                        .font(.subheadline)
                    
                }
                .padding(.bottom, 25)
                
                HStack {
                    VStack {
                        HStack {
                            Text("Total")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(total)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        Rectangle()
                            .foregroundColor(Color("casesColor"))
                            .frame(height: 2)
                    }
                    VStack {
                        HStack {
                            Text("Novos")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(new)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        Rectangle()
                            .foregroundColor(Color("casesColor"))
                            .frame(height: 2)
                    }
                    
                }
                HStack {
                    VStack {
                        HStack {
                            Text("Cresc. diário")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(dailyGrowth)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        Rectangle()
                            .foregroundColor(Color("casesColor"))
                            .frame(height: 2)
                    }
                    VStack {
                        HStack {
                            Text("Cresc. em 14 dias")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                            Spacer()
                            Text(fourteenGrowth)
                                .font(.system(size: 14))
                                .fontWeight(.light)
                        }
                        Rectangle()
                            .foregroundColor(Color("casesColor"))
                            .frame(height: 2)
                    }
                }
                
                GraficoMundialView(loadingPeriod: $loadingPeriod, dataCategory: .constant(.cases), cumulativeOrNew: $cumulativeOrNew, logOrValue: $logOrValue,
                                   covidData: covidData)
                .frame(height: 100)
                .padding(.top, 30)
                .padding(.bottom, 27)
                
                
                HStack {
                    Picker(selection: $cumulativeOrNew, label: Text("X-Axis")) {
                        Text("Novo").tag(CumulativeOrNew.new)
                        Text("Cumulativo").tag(CumulativeOrNew.cumulative)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker(selection: $logOrValue, label: Text("Y-Axis")) {
                        Text("Valor").tag(LogOrValue.value)
                        Text("Log").tag(LogOrValue.log)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.bottom, 8)
                
                Picker(selection: $loadingPeriod, label: Text("Período sel.")) {
                    Text("1 semana").tag(LoadingPeriod.week)
                    Text("1 mês").tag(LoadingPeriod.month)
                    Text("3 meses").tag(LoadingPeriod.threeMonth)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.vertical)
            
            Divider()
            
            HStack {
                Text("Atualizado em:")
                Text(updated)
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.bottom, 20)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBackground),Color(.systemBackground), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom))
        
    }
}
    struct MundialPainelDetalheMortesView: View
    {
        var covidData: MundialModel
        var defaultLang: String?
        var localeIdentifier: String {
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
        
        var period: String {
            switch loadingPeriod {
            case .week: return "in the past week"
            case .month: return "in the past month"
            case .threeMonth: return "in the past three months"
            }
        }
        
        var days: Int {
            switch loadingPeriod {
            case .week: return 7
            case .month: return 30
            case .threeMonth: return 90
            }
        }
        
//        func updateView(num: Double?=nil, day: Double?=nil)
//        {
//            if let _ = num, let safe_day = day {
//                let modifiedDate = Calendar.current.date(byAdding: .day, value: -days + Int (safe_day), to: Date())!
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = .medium
//                dateFormatter.timeStyle = .none
//                dateFormatter.locale = Locale(identifier: localeIdentifier)
//                updated = dateFormatter.string(from: modifiedDate)
//
//                total = String(covidData.getTodayCases(offset: days-Int(safe_day)))
//                new = String(covidData.getTodayNewCases(offset: days-Int(safe_day)))
//                dailyGrowth = covidData.getDailyGrowthRate(offset: days-Int(safe_day))
//                fourteenGrowth = covidData.get14DaysGrowthRate(offset: days-Int(safe_day))
//                return
//            }
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .none
//            dateFormatter.locale = Locale(identifier: localeIdentifier)
//            updated = dateFormatter.string(from: Date())
//
//            total = String(covidData.getTodayCases())
//            new = String(covidData.getTodayNewCases())
//            dailyGrowth = covidData.getDailyGrowthRate()
//            fourteenGrowth = covidData.get14DaysGrowthRate()
//        }
        
        
        var body: some View {
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Mortes")
                            .font(.system(size: 32, weight: .black))
                            .foregroundColor(Color("deathsColor"))
                        //                    Divider()
                        //                        .padding(.vertical, 3)
                        Text(updated)
                            .font(.system(size: 18, weight: .black))
                        //                        .foregroundColor(Color("casesColor"))
                        //                        .font(.subheadline)
                        
                    }
                    .padding(.bottom, 25)
                    
                    HStack {
                        VStack {
                            HStack {
                                Text("Total")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Spacer()
                                Text(total)
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                            }
                            Rectangle()
                                .foregroundColor(Color("deathsColor"))
                                .frame(height: 2)
                        }
                        VStack {
                            HStack {
                                Text("Novos")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Spacer()
                                Text(new)
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                            }
                            Rectangle()
                                .foregroundColor(Color("deathsColor"))
                                .frame(height: 2)
                        }
                        
                    }
                    HStack {
                        VStack {
                            HStack {
                                Text("Cresc. diário")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Spacer()
                                Text(dailyGrowth)
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                            }
                            Rectangle()
                                .foregroundColor(Color("deathsColor"))
                                .frame(height: 2)
                        }
                        VStack {
                            HStack {
                                Text("Cresc. 14 dias")
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                                Spacer()
                                Text(fourteenGrowth)
                                    .font(.system(size: 14))
                                    .fontWeight(.light)
                            }
                            Rectangle()
                                .foregroundColor(Color("deathsColor"))
                                .frame(height: 2)
                        }
                    }
                    
                    GraficoMundialView(loadingPeriod: $loadingPeriod, dataCategory: .constant(.cases), cumulativeOrNew: $cumulativeOrNew, logOrValue: $logOrValue,
                                       covidData: covidData)
                    .frame(height: 100)
                    .padding(.top, 30)
                    .padding(.bottom, 27)
                    
                    
                    HStack {
                        Picker(selection: $cumulativeOrNew, label: Text("X-Axis")) {
                            Text("Novo").tag(CumulativeOrNew.new)
                            Text("Cumulativo").tag(CumulativeOrNew.cumulative)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Picker(selection: $logOrValue, label: Text("Y-Axis")) {
                            Text("Valor").tag(LogOrValue.value)
                            Text("Log").tag(LogOrValue.log)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.bottom, 8)
                    
                    Picker(selection: $loadingPeriod, label: Text("Período sel.")) {
                        Text("1 semana").tag(LoadingPeriod.week)
                        Text("1 mês").tag(LoadingPeriod.month)
                        Text("3 meses").tag(LoadingPeriod.threeMonth)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.vertical)
                
                Divider()
                
                HStack {
                    Text("Atualizado em:")
                    Text(updated)
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBackground),Color(.systemBackground), Color(.systemGray6)]), startPoint: .top, endPoint: .bottom))
            
        }
    }


