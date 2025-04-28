//
//  SwiftUIView.swift
//  Horno3
//
//  Created by Alumno on 21/04/25.
//

import SwiftUI

struct SheetView: View {
    @State private var isSheetPresented: Bool = true
    @Binding var isExpanded: Bool
    @StateObject var viewModel = IndoorMapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            MapaIndoorView(isExpanded: $isExpanded)
                .frame(width: .infinity, height: .infinity)
                .edgesIgnoringSafeArea(.all)
                .sheet(isPresented: $isSheetPresented) {
                    print("Sheet dismissed!")
                } content: {
                    SheetBar()
                        .presentationDetents([.fraction(0.2), .fraction(0.35),.large])
                        .presentationBackgroundInteraction(.enabled)
                }
        }
            .frame(width: .infinity, height: .infinity)

    }
}



#Preview() {
    @Previewable @State var isExpanded = true
    return SheetView(isExpanded: $isExpanded)
}
