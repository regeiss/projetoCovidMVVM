//
//  PaisPainelExtenso.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 12/03/23.
//

import SwiftUI

struct PaisPainelExtenso: View
{
    var pais: PaisModelElement
    var body: some View
    {
        HeaderView(nomeView: "Pais detalhe", nomeMenu: "Voltar")
        Text(pais.country)
    }
}

