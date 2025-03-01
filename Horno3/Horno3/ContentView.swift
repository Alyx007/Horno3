//
//  ContentView.swift
//  Try1
//
//  Created by Apus on 27/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*Button("Hacer anuncio"){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIAccessibility.post(notification: .announcement, argument: "First Try")*/
        TabView {
            tab1
                .tabItem {
                    Label("Tab 1", systemImage: "circle")
                }
            tab2
                .tabItem {
                    Label("Tab 2", systemImage: "circle")
                }
            tab3
                .tabItem {
                    Label("Tab 3", systemImage: "circle")
                }
            
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }
            }
private var tab1: some View {
    ZStack {
        LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        VStack(alignment: .leading) {
            Image(systemName: "swift")
            Text("Bienvenido")
                .foregroundColor(.black)
            Text("Al horno 3")
            
        }
        .foregroundColor(.white)
        .font(.largeTitle)
        .fontWeight(.black)
        
    }
}
    private var tab2: some View {
        ZStack {
            LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Image(systemName: "swift")
                Text("Welcome")
                    .foregroundColor(.black)
                Text("This is page 2")
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
        }
    }
private var tab3: some View {
    ZStack {
        LinearGradient(colors: [.yellow, .green], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        VStack(alignment: .leading) {
            Image(systemName: "swift")
            Text("你好")
                .foregroundColor(.black)
            Text("这是第3页")
        }
        .foregroundColor(.white)
        .font(.largeTitle)
        .fontWeight(.black)
        
        
        Button("Skip>>") {
            
        }
        .accessibilityLabel("Skip button")
        .accessibilityHint("Tap to skip the current screen")
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(8)
        .frame(maxWidth: .infinity, alignment: .topTrailing)
        .padding()
    }
    }
                                          
#Preview {
    ContentView()
}
