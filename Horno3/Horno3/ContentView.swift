//
//  ContentView.swift
//  MAPImplementacion
//
//  Created by Alumno on 13/03/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            if isExpanded {
                FullMapView(isExpanded: isExpanded)
                    .edgesIgnoringSafeArea(.all) // Expand to full screen
            } else {
                MiniMapView(isExpanded: isExpanded)
                    .frame(width: 350, height: 200) // Mini map size
            }
        }
    }
}

#Preview {
    ContentView()
}
