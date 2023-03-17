//
//  PlaceCardStyle.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 13/03/23.
//

import SwiftUI

struct PlaceCardStyle: ViewModifier
{
    func body(content: Content) -> some View
    {
        content
            .background(Color("CardBackground"))
            .cornerRadius(10)
            .shadow(radius: 1)
            .padding([.leading, .trailing], 10)
    }
}

extension View
{
    func placeCardStyle() -> some View
    {
        self.modifier(PlaceCardStyle())
    }
}
