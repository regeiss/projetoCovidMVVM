//
//  AjustesView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/03/23.
//

import SwiftUI

struct AjustesView: View {
    var body: some View {
        ScrollView
        {
            ContinenteListaView()
        }
    }
}

struct AjustesView_Previews: PreviewProvider {
    static var previews: some View {
        AjustesView()
    }
}
