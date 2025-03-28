//
//  ContentView.swift
//  Horno3
//
//  Created by Ranferi Márquez Puig on 18/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isExpanded = false
    
    var body: some View {
                
        TabView {
            InicioView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            
            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gear")
                }
            
            ScannerView()
                .tabItem {
                    Label("Escáner", systemImage: "qrcode.viewfinder")
                }
        }
    }
}

#Preview {
    ContentView()
}

