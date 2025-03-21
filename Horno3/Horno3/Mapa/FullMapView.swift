//
//  FullMapView.swift
//  MAPImplementacion
//
//  Created by Alumno on 13/03/25.
//

import SwiftUI
import MapKit

struct FullMapView: View {
    @Binding var isExpanded: Bool
    @State private var isSheetPresented = false
    
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
                        isExpanded.toggle()
                    }
                })
                {
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .font(.title)
                        .foregroundColor(.orange)
                        .background(.white)
                        .clipShape(.circle)
                        .frame(maxWidth: 75, maxHeight: 75)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .edgesIgnoringSafeArea(.all)
            ZStack{
                VStack {
                    Spacer()
                    MapaSheetView()
                        .frame(height: 300)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}
#Preview() {
    @Previewable @State var isExpanded = true
    return FullMapView(isExpanded: $isExpanded)
}
