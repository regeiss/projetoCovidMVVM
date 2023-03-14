//
//  PaisPainelExtensoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 12/03/23.
//

import SwiftUI

struct PaisPainelExtensoView: View
{
    @Environment(\.dismiss) var dismiss
    var pais: PaisModelElement
    
    var body: some View
    {
        VStack
        {
            Button("Fechar") { dismiss()}
            Text(pais.country)
            Text(pais.continent)
        }
    }
}

