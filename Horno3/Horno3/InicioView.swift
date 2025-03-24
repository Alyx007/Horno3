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
                    VStack {
                        MiniMapView(isExpanded: $isExpanded)
                        Text("Mapa del museo")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 80)
                    .edgesIgnoringSafeArea(.all)
                }
            }
            VStack{
                TabView {
                    Atracciones()
                    EventoDiario()
                }.tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    InicioView()
}
