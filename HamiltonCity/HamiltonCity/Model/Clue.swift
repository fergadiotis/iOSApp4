//
//  Clue.swift
//  HamiltonCity
//
//  Created by Tassos Fergadiotis on 2025-02-09.
//

import Foundation
import CoreLocation

struct Clue: Identifiable {
    let id = UUID()
    let businessName: String
    let text: String
    var found: Bool
    let latitude: Double
    let longitude: Double
    var image: Data?
    
    // Additional business info
    var businessAddress: String?
    var businessHours: String?
    var businessCategory: BusinessCategory
    
    // Computed property for map integration
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum BusinessCategory {
    case restaurant
    case retail
    case entertainment
    case culture
    case park
    case history
}
