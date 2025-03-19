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
                FullMapView(isExpanded: $isExpanded)
            } else {
                MiniMapView(isExpanded: $isExpanded)
                Text("NoEXPANDEN")
            }
        }
    }
}

#Preview {
    ContentView()
}
