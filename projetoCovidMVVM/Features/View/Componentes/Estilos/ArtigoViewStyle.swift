//
//  ArtigoViewStyle.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 08/03/23.
//

import SwiftUI

struct ArtigoViewStyle: ViewModifier
{
    func body(content: Content) -> some View
    {
        content
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 1)
    }
}

extension View
{
    func artigoPainelViewStyle() -> some View
    {
        self.modifier(ArtigoViewStyle())
    }
}
