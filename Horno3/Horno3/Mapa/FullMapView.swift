//
//  FullMapView.swift
//  MAPImplementacion
//
//  Created by Alumno on 13/03/25.
//

import SwiftUI
import MapKit

struct FullMapView: View {
    @State var isExpanded: Bool
    
    @State private var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 25.676189952629407, longitude: -100.28253083624237),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
            ZStack{
                Map(position: $region)
                    .edgesIgnoringSafeArea(.all)
                ZStack(alignment: .top) {
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle() // Collapse when tapped
                        }
                    }) {
                        Image(systemName: "house.circle.fill")
                            .resizable()
                            .font(.title)
                            .foregroundColor(.green)
                            .frame(width: 75, height: 75)
                            
                    }
            }
                
        }
    }
}


#Preview {
    FullMapView(isExpanded: true)
}
