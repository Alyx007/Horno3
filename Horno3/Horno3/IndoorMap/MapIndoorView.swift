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
            ZStack(alignment: .topLeading){
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                })
                {
                    Image(systemName: "house.circle.fill")
                        .resizable()
                        .font(.title)
                        .foregroundColor(.hornoOrange)
                        .background(.white)
                        .clipShape(.circle)
                        .frame(maxWidth: 75, maxHeight: 75)
                        .padding(.leading, 25)
                        .padding(.top, 50)
                }
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
