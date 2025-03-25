//
//  ContentView.swift
//  MAPImplementacion
//
//  Created by Alumno on 13/03/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack{
            VStack{
                    if isExpanded {
                        ZStack(alignment: .top){
                            /*FullMapView(isExpanded: $isExpanded)
                                .frame(width: .infinity, height: .infinity)
                                .edgesIgnoringSafeArea(.all)*/
                            JAUNView()

                        }
                    } else {
                        VStack{
                            MiniMapView(isExpanded: $isExpanded)
                            Text("NoEXPANDEN")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.top, 80)
                        .edgesIgnoringSafeArea(.all)
                        
                    }
            }
            VStack{
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    ContentView()
}
