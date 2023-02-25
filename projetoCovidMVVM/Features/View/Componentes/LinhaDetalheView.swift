//
//  LinhaDetalheView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 24/02/23.
//

import SwiftUI

struct LinhaDetalheView: View
{
    var textOne: String
    var textTwo: String
    var textThree: String
    
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    var frameWidth: CGFloat
    
    var body: some View
    {
        HStack
        {
            CabecalhoView(title: textOne, fontSize: fontSize, fontWeight: fontWeight)
                .frame(width: frameWidth, alignment: .leading)
            Spacer()
            CabecalhoView(title: textTwo, fontSize: fontSize, fontWeight: fontWeight)
                .frame(width: (frameWidth-40), alignment: .trailing)
            CabecalhoView(title: textThree, fontSize: fontSize, fontWeight: fontWeight)
                .frame(width: (frameWidth-40), alignment: .trailing)
        }
        .frame(height: (fontSize+1), alignment: .center)
    }
}
