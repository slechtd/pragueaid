//
//  Target.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation
import MapKit
import Contacts

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
    var mapItem: MKMapItem{
        return MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: [CNPostalAddressStreetKey: name]))
    }
    
    var geometryType: String {return geometry.type}
    var id: String {return properties.id}
    var institutionCode: String {return properties.institutionCode}
    var name: String {return properties.name}
    var updatedAt: String {return properties.updatedAt}
    var country: String {return properties.address.addressCountry}
    var address: String {return "\(properties.address.streetAddress)" + " \(properties.address.addressLocality)"}
    
    var email1: String {return properties.email.getSanitizedElement(at: 0) ?? ""}
    var email2: String {return properties.email.getSanitizedElement(at: 1) ?? ""}
    var telephone1: String {return properties.telephone.getSanitizedElement(at: 0) ?? ""}
    var telephone2: String {return properties.telephone.getSanitizedElement(at: 1) ?? ""}
    var web1: String {return properties.web.getSanitizedElement(at: 0) ?? ""}
    var web2: String {return properties.web.getSanitizedElement(at: 1) ?? ""}
    
    var targetTypeGroup: TargetTypeGroup {return properties.type.group}
    var targetTypeID: TargetTypeID {return properties.type.id}
    var typeDescription: String {return properties.type.typeDescription}
    var openingHours: [OpeningHour]? {return properties.openingHours}
    
    
    func getInfoContent() -> [InfoSectionCellContent] {
        
        return [
            InfoSectionCellContent(action: .none, textLine1: typeDescription, textLine2: nil, icon: .type),
            InfoSectionCellContent(action: .address, textLine1: address, textLine2: nil, icon: .address),
            InfoSectionCellContent(action: .email, textLine1: email1, textLine2: email2, icon: .email),
            InfoSectionCellContent(action: .phone, textLine1: telephone1, textLine2: telephone2, icon: .phone),
            InfoSectionCellContent(action: .web, textLine1: web1, textLine2: web2, icon: .web)
        ]
    }
    
    
    func getOpenings() -> [String] {
        guard let openingHours = openingHours else {return []}
        guard !openingHours.isEmpty else { return [] }
        
        var result: [String] = ["Monday: Closed", "Tuesday: Closed", "Wednesday: Closed", "Thursday: Closed", "Friday: Closed", "Saturday: Closed", "Sunday: Closed", "Public Holidays: Closed", ]
        
        for i in openingHours {
            switch i.dayOfWeek {
            case .monday:
                result[0] = "Monday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .tuesday:
                result[1] = "Tuesday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .wednesday:
                result[2] = "Wednesday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .thursday:
                result[3] = "Thursday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .friday:
                result[4] = "Friday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .saturday:
                result[5] = "Saturday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .sunday:
                result[6] = "Sunday: " + "\(i.opens)" + "-" + "\(i.closes)"
            case .publicHolidays:
                result[7] = "Public Holidays: " + "\(i.opens)" + "-" + "\(i.closes)"
            }
        }
        return result
    }
    
}



