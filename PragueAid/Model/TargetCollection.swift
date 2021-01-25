//
//  Location.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation
import MapKit

//This is a model used to parse json fetched via NetworkManager. The Target class itself is in its own file.

class TargetCollection: Codable {
    let features: [Target]
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
    let type: TargetType

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


struct TargetType: Codable {
    let typeDescription: String
    let group: TargetTypeGroup
    let id: TargetTypeID

    enum CodingKeys: String, CodingKey {
        case group, id
        case typeDescription = "description"
    }
}


enum TargetTypeGroup: String, Codable {
    case healthCare = "health_care"
    case pharmacies = "pharmacies"
}


enum TargetTypeID: String, Codable {
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





