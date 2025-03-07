//
//  InicioView.swift
//  Horno3
//
//  Created by Apus on 04/03/25.
//

import SwiftUI

struct InicioContentView: View {
    let tab: Tab
    
    var body: some View {
        //VStack{
            ZStack{
                Image("HornoImagenFondo")
                    .resizable()
                    .frame(height: .infinity)
                    .edgesIgnoringSafeArea(.all)
                //Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .frame(width: .infinity, height: 500)
                        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
                    ZStack{
                        Text("Vive Experiencias")
                            .frame(width: 300, height: 300, alignment: .top)
                            .offset(x:-40)
                        
                        Text("Elevadas")
                            .frame(width: 300, height: 300, alignment: .topTrailing)
                            .offset(x:-45)
                            .padding(.bottom, 30)

                    }
                    
                }
                VStack{
                    HStack{
                        Button{
                            
                        } label: {
                            Image(systemName: "newspaper")
                                .resizable()
                                .frame(width: 75, height: 75)
                            Text("Exhibiciones")
                                .accessibilityLabel("Exhibiciones")
                                .accessibilityHint("Doble clic para ver las exhibiciones")
                        }
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "globe.americas")
                                .resizable()
                                .frame(width: 75, height: 75)
                            Text("Mapa")
                                .accessibilityLabel("Mapa")
                                .accessibilityHint("Doble clic para ir al mapa")
                        }
                    }
                    
                    HStack{
                        Button{
                            
                        } label: {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 75, height: 75)
                            Text("Eventos")
                                .accessibilityLabel("Eventos")
                                .accessibilityHint("Doble clic para ver eventos")
                        }
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "map")
                                .resizable()
                                .frame(width: 75, height: 75)
                            Text("Recorrido Personalizado")
                                .accessibilityLabel("Recorrido")
                                .accessibilityHint("Doble clic para tu recorrido personalizado")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
            }
        //}
    }
}

struct AjustesContentView: View {
    let tab: Tab
    var body: some View {
        Text("Aqui van los ajustes")
    }
}
struct ScannerContentView: View {
    let tab: Tab
    var body: some View {
        Text("Aqui va la camara")
    }
}
struct InicioView: View {
    var body: some View {
        
        WithTabBar { selection in
            switch selection {
            case .Inicio:
                InicioContentView(tab: .Inicio)
            case .Ajustes:
                    AjustesContentView(tab: .Ajustes)
            case .Scanner:
                ScannerContentView(tab: .Scanner)
            }
        }
    }
}

    #Preview {
        InicioView()
    }

