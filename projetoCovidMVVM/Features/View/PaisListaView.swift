//
//  PaisListaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//
//
//  PaisListaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI

struct PaisListaView: View
{
    @StateObject private var vm = PaisListaViewModelImpl(service: NetworkService())
    
    @State private var searchText: String = ""
    @State var isSearching = false
    
    var body: some View
    {
        NavigationView
        {
            VStack() 
            {
                OKSearchBar(searchText: $searchText, isSearching: $isSearching)
                    .padding(.vertical, 5)
                Divider()
                    .frame(height: 4)
                    .background(Color(.systemGray2))
                    .padding(.bottom, 5)
                Section(header:
                            HStack 
                            {
                                Cabecalho(title: "País",
                                        fontSize: 22,
                                        fontWeight: .bold)
                                    .frame(width: 130, alignment: .leading)
                                    .onTapGesture {
                                        vm.sortedBy = "name"
                                        vm.getCountryListData()
                                    }
                                Spacer()
                                Cabecalho(title: "Casos",
                                        fontSize: 22,
                                        fontWeight: .bold)
                                    .frame(width: 90, alignment: .trailing)
                                    .onTapGesture {
                                        vm.sortedBy = "cases"
                                        vm.getCountryListData()
                                    }
                                Cabecalho(title: "Mortes",
                                        fontSize: 22,
                                        fontWeight: .bold)
                                    .frame(width: 90, alignment: .trailing)
                                    .onTapGesture {
                                        vm.sortedBy = "deaths"
                                        vm.getCountryListData()
                                    }
                            }
                ) 
                {
                    List 
                    {
                        ForEach(searchText.isEmpty ? vm.countriesData : vm.countriesData.filter 
                        {
                            $0.country.lowercased().contains(searchText.lowercased())
                        }, id: \.country) { country in
                            OKListRow(textOne: country.country,
                                      textTwo: "\(country.cases.numberFormat())",
                                      textThree: "\(country.deaths.numberFormat())",
                                      fontSize: 18,
                                      fontWeight: .medium,
                                      frameWidth: 140)
                                .foregroundColor(Color(.secondaryLabel))
                                .onTapGesture { vm.selectedCountry = country }
                        }
                        //.listRowInsets(EdgeInsets())
                    }
                }
                .onAppear(perform: { vm.getListaPaises()})
            }
            .navigationBarTitle("Country List", displayMode: .inline)
            // .sheet(isPresented: $vm.isShowingDetailView) {
            //     CountryDetailView(countryData: vm.selectedCountry ?? MockData.sampleCountryData, isShowingDetail: $vm.isShowingDetailView)
            }
            Text("Lista Pais")
        }//.searchable(text: $searchText, placement: .automatic, prompt: Text("?????"))
        .navigationBarTitle("Country List", displayMode: .inline)
        .sheet(isPresented: $vm.isShowingDetailView) {
                CountryDetailView(countryData: vm.selectedCountry ?? MockData.sampleCountryData, isShowingDetail: $vm.isShowingDetailView)
    }.navigationViewStyle(StackNavigationViewStyle())
        .blur(radius: vm.isShowingDetailView ? 5 : 0)
}

struct Cabecalho: View 
{
    var title: String
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    
    var body: some View 
    {
        Text(title)
            .font(.system(size: fontSize, weight: fontWeight, design: .serif))
            .shadow(color: .secondary, radius: 0.5, x: 0.3, y: 0.3)
    }
}

