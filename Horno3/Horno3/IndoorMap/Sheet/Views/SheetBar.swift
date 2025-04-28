//
//  SheetBar.swift
//  Horno3
//
//  Created by Alumno on 21/04/25.
//

import SwiftUI
import Foundation

struct Park: Identifiable {
  let id = UUID()
  let name: String
}

struct SheetBar: View {
  @State private var searchText = ""

  let parks: [Park] = [
    Park(name: "Banos 1"),
    Park(name: "Laboratorio de Innovacion"),
    Park(name: "Galeria del Acero"),
    Park(name: "Galeria de la Historia"),
    Park(name: "Banos 2"),
    Park(name: "Tienda"),
    Park(name: "Guarda Cosas"),
    Park(name: "Lobby")
  ]

  var body: some View {
    NavigationStack {
      List {
        ForEach(parks.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }) { park in
          Text(park.name)
        }
      }
      .listStyle(.plain)
      .scrollContentBackground(.hidden)
      .navigationTitle("Exhibiciones")
      .searchable(text: $searchText)
    }
    .padding()
    .interactiveDismissDisabled()
    .presentationDetents([.height(200), .large])
    .presentationBackground(.regularMaterial)
    .presentationBackgroundInteraction(.enabled(upThrough: .large))
  }
}

#Preview {
    SheetBar()
}
