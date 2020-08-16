//
//  Location.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation
import MapKit


class LocationCollection: Codable {
    let features: [Location]
}


class Location: NSObject, Codable, MKAnnotation {
    private let geometry: Geometry
    private let properties: Properties
    
    var title: String? {return properties.name}
    var subtitle: String? { return properties.name}
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


struct Geometry: Codable {
    let coordinates: [Double]
    let type: String
}


struct Properties: Codable {
    let id, institutionCode, name, updatedAt: String
    let address: Address
    let email, telephone, web: [String]
    let openingHours: [OpeningHour]?
    let type: LocationType

    enum CodingKeys: String, CodingKey {
        case address, email, id, name, telephone, type, web
        case institutionCode = "institution_code"
        case openingHours = "opening_hours"
        case updatedAt = "updated_at"
    }
}


struct Address: Codable {
    let addressCountry, addressLocality, streetAddress: String

    enum CodingKeys: String, CodingKey {
        case addressCountry = "address_country"
        case addressLocality = "address_locality"
        case streetAddress = "street_address"
    }
}


struct OpeningHour: Codable {
    let closes: String
    let dayOfWeek: DayOfWeek
    let opens: String

    enum CodingKeys: String, CodingKey {
        case closes, opens
        case dayOfWeek = "day_of_week"
    }
}


enum DayOfWeek: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case publicHolidays = "PublicHolidays"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}


struct LocationType: Codable {
    let typeDescription: String
    let group: LocationTypeGroup
    let id: LocationTypeID

    enum CodingKeys: String, CodingKey {
        case group, id
        case typeDescription = "description"
    }
}


enum LocationTypeGroup: String, Codable {
    case healthCare = "health_care"
    case pharmacies = "pharmacies"
}


enum LocationTypeID: String, Codable {
    case a = "A"
    case l = "L"
    case lo = "LO"
    case no = "NO"
    case o = "O"
    case oovl = "OOVL"
    case z = "Z"
    case zOovl = "Z/OOVL"
    case zsFn = "ZS-FN"
    case zsN = "ZS-N"
    case zsNnp = "ZS-NNP"
    case zsOaz = "ZS-OAZ"
    case zsOzz = "ZS-OZZ"
    case zsOzzz = "ZS-OZZZ"
    case zsVzp = "ZS-VZP"
    case zsZds = "ZS-ZDS"
    case zsZs = "ZS-ZS"
}





