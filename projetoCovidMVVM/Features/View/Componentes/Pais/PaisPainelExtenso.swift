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
        Text(pais.country)
    }
}

