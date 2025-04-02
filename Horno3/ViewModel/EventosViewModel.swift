//
//  EventoViewModel.swift
//  Horno3
//
//  Created by Alumno on 01/04/25.
//

import Foundation

class EventoViewModel: ObservableObject {
    @Published var evento: [Evento] = []
    
    init() {
        cargarDatos()
    }
    
    func cargarDatos() {
            if let url = Bundle.main.url(forResource: "eventos-temporales", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let eventoCargado = try? decoder.decode([Evento].self, from: data) {
                DispatchQueue.main.async {
                    self.evento = eventoCargado
                }
            }
        }
    }
}
