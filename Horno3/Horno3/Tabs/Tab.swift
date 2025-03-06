//
//  Tab.swift
//  Horno3
//  Animaciones para el TabView
//  Created by Apus on 04/03/25.
//

import SwiftUI
import Foundation

enum Tab: CaseIterable{
    case Inicio
    case Ajustes
    case Scanner
    
    var item: TabItem{
        switch self{
        case .Inicio:
                return TabItem.init(title: "Inicio", systemImage: "house", color: .orange)
        case .Ajustes:
            return TabItem.init(title: "Ajustes", systemImage: "gearshape", color: .blue)
        case .Scanner:
            return TabItem.init(title: "Scanner", systemImage: "barcode", color: .green)
            
        }
    }
}

struct TabItem: Identifiable, Hashable{
    let id = UUID()
    let title: String
    let systemImage: String
    let color: Color
    
}
