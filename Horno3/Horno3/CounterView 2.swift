import SwiftUI
import MapKit

struct IndoorMapView: UIViewControllerRepresentable {
    // This typealias defines the type of UIViewController that is being wrapped.
    typealias UIViewControllerType = IndoorMapViewController

    // This function creates and configures the `IndoorMapViewController`.
    func makeUIViewController(context: Context) -> IndoorMapViewController {
        let indoorMapVC = IndoorMapViewController()
        
        // Here you can configure any necessary properties before presenting the view.
        // For example, if you need to pass data to the IndoorMapViewController, do it here.
        
        return indoorMapVC
    }

    // This function is used to update the `IndoorMapViewController` when SwiftUI state changes.
    func updateUIViewController(_ uiViewController: IndoorMapViewController, context: Context) {
        // No need to do anything here if the controller is static and doesn't depend on SwiftUI state
        // You can update the controller’s data if needed
    }
}

struct JAUNView: View {
    var body: some View {
        IndoorMapView()
            .edgesIgnoringSafeArea(.all) // Optional: If you want the map to take up the whole screen.
    }
}
#Preview {
    JAUNView()
}
