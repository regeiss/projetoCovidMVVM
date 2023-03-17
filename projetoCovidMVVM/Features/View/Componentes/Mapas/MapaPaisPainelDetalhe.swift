//
//  MapaPaisPainelDetalhe.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 14/03/23.
//

import SwiftUI
import MapKit

struct MapaPaisPainelDetalhe: View
{
    @State var mapRegion: MKCoordinateRegion
    
    var body: some View
    {
        VStack
        {
            Map(coordinateRegion: $mapRegion)
                .padding()
        }
    }
    

}

