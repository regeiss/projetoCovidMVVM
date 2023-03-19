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
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}

