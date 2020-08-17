//
//  Target.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation
import MapKit

class Target: NSObject, Codable, MKAnnotation {
    private let geometry: Geometry
    private let properties: Properties
    
    var title: String? {return properties.name}
    var subtitle: String? { return properties.type.typeDescription}
    var coordinate: CLLocationCoordinate2D {
        let lat = self.geometry.coordinates[1]
        let lon = self.geometry.coordinates[0]
        let result = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        return result
    }
    
    var geometryType: String {return geometry.type}
    var id: String {return properties.id}
    var institutionCode: String {return properties.institutionCode}
    var name: String {return properties.name}
    var updatedAt: String {return properties.updatedAt}
    var country: String {return properties.address.addressCountry}
    var address: String {return "\(properties.address.streetAddress)" + " \(properties.address.addressLocality)"}
    var email: [String] {return properties.email}
    var telephone: [String] {return properties.telephone}
    var web: [String] {return properties.web}
    var locationTypeGroup: LocationTypeGroup {return properties.type.group}
    var locationTypeID: LocationTypeID {return properties.type.id}
    var typeDescription: String {return properties.type.typeDescription}
    var openingHours: [OpeningHour]? {return properties.openingHours}
}
