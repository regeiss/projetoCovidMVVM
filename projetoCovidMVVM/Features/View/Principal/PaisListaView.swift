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
                BarraBuscaView(searchText: $searchText, isSearching: $isSearching)
                    .padding(.vertical, 5)
                Divider()
                    .frame(height: 4)
                    .background(Color(.systemGray2))
                    .padding(.bottom, 5)
                Section(header:
                            HStack
                        {
                    CabecalhoView(title: "País",
                                  fontSize: 22,
                                  fontWeight: .bold)
                    .frame(width: 130, alignment: .leading)
                    Spacer()
                    CabecalhoView(title: "Casos",
                                  fontSize: 22,
                                  fontWeight: .bold)
                    .frame(width: 90, alignment: .trailing)
                    CabecalhoView(title: "Mortes",
                                  fontSize: 22,
                                  fontWeight: .bold)
                    .frame(width: 90, alignment: .trailing)
                }
                )
                // MARK TODO: ajustar foreach
                {
                    let lista = [vm.paises]
                    List
                    {
                        ForEach(searchText.isEmpty ? lista: lista.filter
                                {
                            $0.lista.country.lowercased().contains(searchText.lowercased())
                        }, id: \.country) { country in
                            LinhaDetalheView(textOne: country.country,
                                             textTwo: "\(country.cases.numberFormat())",
                                             textThree: "\(country.deaths.numberFormat())",
                                             fontSize: 18,
                                             fontWeight: .medium,
                                             frameWidth: 140)
                            .foregroundColor(Color(.secondaryLabel))
                            //.onTapGesture { vm.selectedCountry = country }
                        }
                        //.listRowInsets(EdgeInsets())
                    }
                }
                .task { await vm.getListaPaises() }
                .alert("Error", isPresented: $vm.hasError, presenting: vm.state) { detail in Button("Retry", role: .destructive)
                        { Task {await vm.getListaPaises()}}}
                          message: { detail in if case let .failed(error) = detail { Text(error.localizedDescription)}}
            }
            .navigationBarTitle("Country List", displayMode: .inline)
        }
    }
}



