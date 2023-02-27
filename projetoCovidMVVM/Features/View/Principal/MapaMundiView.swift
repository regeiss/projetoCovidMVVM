//
//  MapaMundiView.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 11/02/23.
//

import SwiftUI
import MapKit

struct MapaMundiView: View
{
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020),
            latitudinalMeters: 750, longitudinalMeters: 750)
    
    var body: some View
    {
        Map(coordinateRegion: $region)
    }
}

