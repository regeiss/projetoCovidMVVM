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
            Text(textOne)
                .font(.system(size: fontSize, weight: fontWeight))
            Spacer()
            Text(textTwo)
                .font(.system(size: fontSize, weight: fontWeight))
                .frame(width: (frameWidth-50), alignment: .trailing)
            Text(textThree)
                .font(.system(size: fontSize, weight: fontWeight))
                .frame(width: (frameWidth-40), alignment: .trailing)
        }
        .frame(height: (fontSize+1), alignment: .center)
        .padding([.leading, .trailing], 5)
    }
}
