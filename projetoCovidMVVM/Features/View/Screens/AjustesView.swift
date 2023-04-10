//
//  AjustesView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 15/03/23.
//

import SwiftUI

struct AjustesView: View
{
    var body: some View
    {
        NavigationView {
           List {
              // first section
              Section(header: Text("Conta")) {
                  NavigationLink(destination: EmptyView(), label: {
                     SettingRowView(title: "Minha conta",
                     systemImageName: "person")
                  })
              }

              // second section
              Section(header: Text("Mais detalhes")) {
                   NavigationLink(destination: EmptyView(), label: {
                      SettingRowView(title: "Custo",
                      systemImageName:"dollarsign.circle")
                   })
                         
                   NavigationLink(destination: EmptyView(), label: {
                       SettingRowView(title: "Anúncios",
                       systemImageName: "newspaper")
                   })
              }
           }
           .navigationTitle(Text("Ajustes"))
        }
    }
}

struct SettingRowView: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        HStack (spacing: 15) {
            Image(systemName: systemImageName)
            Text (title)
        }
    }
}

struct AjustesView_Previews: PreviewProvider {
    static var previews: some View {
        AjustesView()
    }
}
