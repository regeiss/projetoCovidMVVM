//
//  ContinentePainelDetalheView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 17/03/23.
//

import SwiftUI

struct ContinentePainelDetalheView: View
{
    @Environment(\.dismiss) var dismiss
    var nome: String
    
    var body: some View
    {
        VStack
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
            Text(nome)
            Spacer()
        }
    }
}
