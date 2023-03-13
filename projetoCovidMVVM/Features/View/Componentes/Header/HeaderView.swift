//
//  HeaderView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/03/23.
//

import SwiftUI
import NavigationStack

@available(iOS 16.0, *)
struct HeaderView: View
{
    let router = MyRouter.shared
    var nomeViewRetorno: String
    var nomeMenu: String
    
    var body: some View
    {
        VStack()
        {
            HStack
            {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.leading])
                    .onTapGesture {
                        headerRouter(voltarPara: nomeViewRetorno)
                    }
                
                Text(nomeMenu).foregroundColor(.blue).font(.system(.title3, design: .rounded))
                Spacer()
                Image(systemName: "house")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .padding([.trailing])
                    .onTapGesture {
                        router.toMenu()
                    }
            }
        }
    }
    
    func headerRouter(voltarPara: String)
     {
         switch voltarPara
         {
         case "lstArtigo":
             //router.toPainelArtigoCompacto(artigo: ArtigoModelElement(from: <#Decoder#>))
             router.toMenu()

         default:
             router.toMenu()
         }
         
     }
    
}
