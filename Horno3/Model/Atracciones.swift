//
//  Atracciones.swift
//  Horno3
//
//  Created by Ranferi Márquez Puig on 24/03/25.
//

import SwiftUI
import Foundation

struct Atracciones: View {
    @StateObject private var viewModel = AtraccionesViewModel()
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading) {
                Text("Atracciones")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.atracciones) { atraccion in
                        NavigationLink(destination: DetalleAtraccion(atraccion: atraccion)) {
                            VStack {
                                Image(atraccion.imagen)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text(atraccion.titulo)
                                    .font(.headline)
                                    .foregroundColor(.indigo)
                                
                                Text(atraccion.descripcion)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                    .frame(width: 200)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
    }
}

#Preview {
    Atracciones()
}

