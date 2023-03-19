//
//  CabecalhoView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 24/02/23.
//

import SwiftUI

struct CabecalhoView:  View
{
    var title: String
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    
    var body: some View
    {
        Text(title)
            .font(.system(size: fontSize, weight: fontWeight))
            //.shadow(color: .secondary, radius: 0.5, x: 0.3, y: 0.3)
    }
}
