//
//  MiniMapView.swift
//  MAPImplementacion
//
//  Created by Alumno on 13/03/25.
//

import SwiftUI
import MapKit

struct MiniMapView: View {
    @State var isExpanded: Bool
    
    @State private var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 25.676189952629407, longitude: -100.2825522939145),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        Map(position: $region, interactionModes: [])
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle() // Expand when tapped
                }
            }
    }
}

#Preview {
    MiniMapView(isExpanded: false)
}
