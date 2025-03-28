import SwiftUI
import MapKit

struct InicioView: View {
    @State private var isExpanded = false
    
    var body: some View {
        ZStack {
            // Fondo degradado
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.6), Color.orange.opacity(0.6), Color.yellow.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
                VStack {
                    if isExpanded {
                        ZStack(alignment: .top) {
                            FullMapView(isExpanded: $isExpanded)
                                .frame(width: .infinity, height: .infinity)
                                .edgesIgnoringSafeArea(.all)
                        }
                    } else {
                        ScrollView {
                        VStack {
                            MiniMapView(isExpanded: $isExpanded)
                                .padding(.horizontal)
                            Text("Mapa del museo")
                                .font(.headline)
                                .foregroundColor(.white)
                            Atracciones()
                                .tabViewStyle(.page)
                                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                                .frame(height: 400) // Adjust height as needed
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.top, 80)
                        .edgesIgnoringSafeArea(.all)
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    InicioView()
}
