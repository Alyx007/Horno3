//
//  joprueba.swift
//  Dinoseum
//
//  Created by Alumno on 31/03/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct MapaIndoorView: View {
    @StateObject var viewModel = IndoorMapViewModel()
    @Binding var isExpanded: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ZStack(alignment: .topTrailing) {
                IndoorMapView(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.all)
                
                LevelPicker(viewModel: viewModel)
                    .padding(.top, 60)  // Adjust for safe area
                    .padding(.trailing, 15)
                
            }
        }
    }
}

//#Preview {
  //  MapaIndoorView()
//}

#Preview() {
    @Previewable @State var isExpanded = true
    return MapaIndoorView(isExpanded: $isExpanded)
}
