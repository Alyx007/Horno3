//
//  SheetBar.swift
//  Horno3
//
//  Created by Alumno on 21/04/25.
//

import SwiftUI
import Foundation
import MapKit


struct SheetBar: View {
    @StateObject private var vm = GeoJSONViewModel()
    @State private var searchText = ""
    
    /// The currently selected unit (defaults to first if you like)
    @State private var selectedUnit: UnitRoute?
    
    /// The visible map region, driven by `selectedUnit`
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    /// Filtered according to searchText
    private var filteredUnits: [UnitRoute] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return vm.units }
        return vm.units.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: – Map View
                Map(
                    coordinateRegion: $region,
                    annotationItems: selectedUnit.map { [$0] } ?? []
                ) { unit in
                    // A default pin annotation
                    MapMarker(coordinate: unit.coordinate, tint: .red)
                }
                .frame(height: 250)
                .cornerRadius(12)
                .padding(.horizontal)
                .onChange(of: selectedUnit) { newUnit in
                    guard let u = newUnit else { return }
                    // animate map to center on selected unit
                    withAnimation {
                        region.center = u.coordinate
                    }
                }
                
                // MARK: – Searchable List
                List(filteredUnits, id: \.id) { unit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(unit.name)
                                .font(.headline)
                            Text(String(
                                format: "Lat: %.5f  Lon: %.5f",
                                unit.coordinate.latitude,
                                unit.coordinate.longitude
                            ))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                        // Indicate selection
                        if unit.id == selectedUnit?.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // make whole row tappable
                    .onTapGesture {
                        // update selection
                        selectedUnit = unit
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
                .searchable(text: $searchText, prompt: "Search units")
                .disableAutocorrection(true)
            }
            .navigationTitle("Units Map")
            .onAppear {
                // initialize: pick the first unit if available
                if selectedUnit == nil, let first = vm.units.first {
                    selectedUnit = first
                    region.center = first.coordinate
                }
            }
        }
    }
}

#Preview {
    SheetBar()
}
