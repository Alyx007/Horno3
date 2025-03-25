//
//  Test.swift
//  Horno3
//
//  Created by Alumno on 24/03/25.
//
import SwiftUI
import MapKit
import CoreLocation


struct TestView: View {
    @State private var venue: Venue? = nil
    @State private var loadingError: String? = nil
    
    var body: some View {
        VStack {
            if let venue = venue {
                // Show the venue on a map, for example.
                Text("Venue loaded successfully!")
                    // You can add a Map view here to show the venue
            } else if let loadingError = loadingError {
                Text("Error loading venue: \(loadingError)")
                    .foregroundColor(.red)
            } else {
                Text("Loading venue data...")
            }
        }
        .onAppear {
            loadIMDFData()
        }
    }
    
    private func loadIMDFData() {
        // Get the IMDFData directory from the main bundle
        guard let imdfDirectory = Bundle.main.resourceURL?.appendingPathComponent("IMDFData") else {
            loadingError = "IMDFData directory not found in the bundle."
            return
        }
        
        // Try loading the IMDF data
        do {
            let imdfDecoder = IMDFDecoder()
            venue = try imdfDecoder.decode(imdfDirectory)
            
        } catch let error {
            loadingError = "Failed to decode IMDF data: \(error)"
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

