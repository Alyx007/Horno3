//
//  MapaSheetView.swift
//  Horno3
//
//  Created by Alumno on 20/03/25.
//

import SwiftUI

struct MapaSheetView: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack {
            Text("pRUEBA SHHET")
                .font(.headline)

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview {
    MapaSheetView()
}
