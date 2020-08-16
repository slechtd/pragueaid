//
//  Location.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation
import MapKit

class Collection: Codable {
    let features: [Location]
}


class Location: NSObject, Codable, MKAnnotation {
    let type: String
    let properties: Properties
    let geometry: Geometry
    
    var coordinate: CLLocationCoordinate2D {
        let lat = self.geometry.coordinates[1]
        let lon = self.geometry.coordinates[0]
        let result = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        return result
    }
    var title: String? {return properties.name}
    var subtitle: String? { return properties.name}
}


struct Geometry: Codable {
    let coordinates: [Double]
}


struct Properties: Codable {
    let id, name, type, district: String
    let address: String
    let email: String?
    let web: String?
    let telephone: [String]
    let openingHours: [OpeningHour]

    enum CodingKeys: String, CodingKey {
        case id, name, type, district, address, email, web, telephone
        case openingHours = "opening_hours"
    }
}


struct OpeningHour: Codable {
    let day: Day
    let hours: String
}


enum Day: String, Codable {
    case Neděle = "Neděle"
    case Pondělí = "Pondělí"
    case Pátek = "Pátek"
    case Sobota = "Sobota"
    case Středa = "Středa"
    case Svátek = "Svátek"
    case Úterý = "Úterý"
    case Čtvrtek = "Čtvrtek"
}




