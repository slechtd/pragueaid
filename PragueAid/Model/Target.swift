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
    
    //Properties as decoded from json fetches via NetworkManager. 
    private let geometry: Geometry
    private let properties: Properties
    
    //MapKit stuff
    var title: String? {properties.name}
    var subtitle: String? {properties.type.typeDescription}
    var coordinate: CLLocationCoordinate2D {return CLLocationCoordinate2D(latitude: self.geometry.coordinates[1], longitude: self.geometry.coordinates[0])}
    var mapItem: MKMapItem{MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: [CNPostalAddressStreetKey: name]))}
    
    //Other properties formatted for convenient access
    var geometryType: String {geometry.type}
    var id: String {properties.id}
    var institutionCode: String {properties.institutionCode}
    var name: String {properties.name}
    var updatedAt: String {properties.updatedAt}
    var country: String {properties.address.addressCountry}
    var address: String {"\(properties.address.streetAddress)" + " \(properties.address.addressLocality)"}
    var email1: String {properties.email.getSanitizedElement(at: 0)?.removeAllSpaces() ?? ""}
    var email2: String {properties.email.getSanitizedElement(at: 1)?.removeAllSpaces() ?? ""}
    var telephone1: String {properties.telephone.getSanitizedElement(at: 0)?.dropFirstSpace() ?? ""}
    var telephone2: String {properties.telephone.getSanitizedElement(at: 1)?.dropFirstSpace() ?? ""}
    var web1: String {properties.web.getSanitizedElement(at: 0)?.shortenUrl() ?? ""}
    var web2: String {properties.web.getSanitizedElement(at: 1)?.shortenUrl() ?? ""}
    var targetTypeGroup: TargetTypeGroup {properties.type.group}
    var targetTypeID: TargetTypeID {properties.type.id}
    var typeDescription: String {properties.type.typeDescription}
    var openingHours: [OpeningHour]? {properties.openingHours}
    
    
    //Used to pass properties of the Target class to PAInfoCell while populating a tableView
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



