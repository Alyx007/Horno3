/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Extensions to the IMDF types to enable styling overlays/annotations based on their properties.
*/

import SwiftUI
import MapKit

protocol StylableFeature {
    var geometry: [MKShape & MKGeoJSONObject] { get }
    func configure(overlayRenderer: MKOverlayPathRenderer)
    func configure(annotationView: MKAnnotationView)
}

// Provide default empty implementations for these protocol methods.
extension StylableFeature {
    func configure(overlayRenderer: MKOverlayPathRenderer) {}
    func configure(annotationView: MKAnnotationView) {}
}

extension Level: StylableFeature {
    func configure(overlayRenderer: MKOverlayPathRenderer) {
        overlayRenderer.strokeColor = UIColor(named: "LevelStroke")
        overlayRenderer.lineWidth = 2.0
    }
}

extension Unit: StylableFeature {
    // A list of unit categories which we are interested in styling in unique ways. Note: This is not a full list of possible IMDF category names.
    private enum StylableCategory: String {
        case elevator
        case escalator
        case stairs
        case restroom
        case restroomMale = "restroom.male"
        case restroomFemale = "restroom.female"
        case room
        case nonpublic
        case walkway
    }
    
    func configure(overlayRenderer: MKOverlayPathRenderer) {
        if let category = StylableCategory(rawValue: self.properties.category) {
            switch category {
            case .elevator, .escalator, .stairs:
                overlayRenderer.fillColor = UIColor(named: "ElevatorFill")
            case .restroom, .restroomMale, .restroomFemale:
                overlayRenderer.fillColor = UIColor(named: "RestroomFill")
            case .room:
                overlayRenderer.fillColor = UIColor(named: "RoomFill")
            case .nonpublic:
                overlayRenderer.fillColor = UIColor(named: "NonPublicFill")
            case .walkway:
                overlayRenderer.fillColor = UIColor(named: "WalkwayFill")
            }
        } else {
            overlayRenderer.fillColor = UIColor(named: "DefaultUnitFill")
        }

        overlayRenderer.strokeColor = UIColor(named: "UnitStroke")
        overlayRenderer.lineWidth = 1.3
    }
}

extension Opening: StylableFeature {
    func configure(overlayRenderer: MKOverlayPathRenderer) {
        // Match the standard unit fill color so the opening lines match the open areas' colors.
        overlayRenderer.strokeColor = UIColor(named: "WalkwayFill")
        overlayRenderer.lineWidth = 2.0
    }
}

extension Amenity: StylableFeature {
    private enum StylableCategory: String {
        case exhibit
        case restroom
        case room
        
    }
    
    func configure(annotationView: MKAnnotationView) {
        if let category = StylableCategory(rawValue: self.properties.category) {
            switch category {
            case .exhibit:
                let categoryIcon = UIImage(named: self.properties.category)
                if let image = categoryIcon {
                    // Resize the image to a more appropriate size for map annotations
                    let scaledImage = image.scaledToSize(CGSize(width: 30, height: 30))
                    annotationView.image = scaledImage
                } else {
                    annotationView.backgroundColor = UIColor(named: "ExhibitFill")
                }
            case .restroom:
                let categoryIcon = UIImage(named: self.properties.category)
                if let image = categoryIcon {
                    // Resize the image to a more appropriate size for map annotations
                    let scaledImage = image.scaledToSize(CGSize(width: 15, height: 15))
                    annotationView.image = scaledImage
                } else {
                    annotationView.backgroundColor = UIColor(named: "RestroomFill")
                }
            case .room:
                let categoryIcon = UIImage(named: self.properties.category)
                if let image = categoryIcon {
                    // Resize the image to a more appropriate size for map annotations
                    let scaledImage = image.scaledToSize(CGSize(width: 20, height: 20))
                    annotationView.image = scaledImage
                } else {
                    annotationView.backgroundColor = UIColor(named: "RoomFill")
                }
            }
        } else {
            annotationView.backgroundColor = UIColor(named: "DefaultAmenityFill")
        }
        
        // Most Amenities have lower display priority then Occupants.
        annotationView.displayPriority = .defaultLow
    }
}

// Add this UIImage extension for resizing
extension UIImage {
    func scaledToSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}

extension Occupant: StylableFeature {
    private enum StylableCategory: String {
        case restaurant
        case shopping
    }

    func configure(annotationView: MKAnnotationView) {
        if let category = StylableCategory(rawValue: self.properties.category) {
            switch category {
            case .restaurant:
                annotationView.backgroundColor = UIColor(named: "RestaurantFill")
            case .shopping:
                annotationView.backgroundColor = UIColor(named: "ShoppingFill")
            }
        }

        annotationView.displayPriority = .defaultHigh
    }
}
