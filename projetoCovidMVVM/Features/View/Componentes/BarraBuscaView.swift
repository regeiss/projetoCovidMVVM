//
//  BarraBuscaView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 24/02/23.
//

import SwiftUI

struct BarraBuscaView: View
{
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View
    {
        HStack
        {
            HStack
            {
                TextField("Pesquisar país...", text: $searchText)
                    .padding(.leading, 40)
            }
            .padding(.vertical, 7)
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture(perform: { isSearching = true})
            .overlay(
                HStack
                {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching
                    {
                        Button(action: { searchText = "" }, label: { Image(systemName: "xmark.circle.fill")})
                    }
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            
            if isSearching
            {
                Button(action: {
                    isSearching = false
                    searchText  = ""
                    withAnimation(.easeIn) {}
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancelar")
                        .padding(.trailing)
                        .padding(.leading, -10)
                        .accentColor(Color(.systemGray))
                })
                .transition(.move(edge: .trailing))
            }
        }
    }
}
