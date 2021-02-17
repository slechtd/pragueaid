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
    var subtitle: String? {properties.type.group.rawValue.localized()}
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
    var telephone1: String {properties.telephone.getSanitizedElement(at: 0)?.formatPhoneNumber() ?? ""}
    var telephone2: String {properties.telephone.getSanitizedElement(at: 1)?.formatPhoneNumber() ?? ""}
    var web1: String {properties.web.getSanitizedElement(at: 0)?.formatURL() ?? ""}
    var web2: String {properties.web.getSanitizedElement(at: 1)?.formatURL() ?? ""}
    var targetTypeGroup: TargetTypeGroup {properties.type.group}
    var targetTypeID: TargetTypeID {properties.type.id}
    var typeDescription: String {properties.type.typeDescription}
    var openingHours: [OpeningHour]? {properties.openingHours}
    
    
    //Used to pass properties of the Target class to PAInfoCell when populating a tableView
    func getInfoContent() -> [InfoSectionCellContent] {
        return [
            InfoSectionCellContent(action: .none, textLine1: targetTypeGroup.rawValue.localized(), textLine2: nil, icon: .questionmark),
            InfoSectionCellContent(action: .address, textLine1: address, textLine2: nil, icon: .address),
            InfoSectionCellContent(action: .email, textLine1: email1, textLine2: email2, icon: .email),
            InfoSectionCellContent(action: .phone, textLine1: telephone1, textLine2: telephone2, icon: .phone),
            InfoSectionCellContent(action: .web, textLine1: web1, textLine2: web2, icon: .web)
        ]
    }
    
    
    func getOpenings() -> [String] {
        guard let openingHours = openingHours else {return []}
        guard !openingHours.isEmpty else { return [] }
        
        var result: [String] = ["\(otherStrings.monday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.tuesday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.wednesday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.thursday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.friday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.saturday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.sunday.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", "\(otherStrings.publicHolidays.rawValue.localized()): \(otherStrings.closed.rawValue.localized())", ]
        
        for i in openingHours {
            switch i.dayOfWeek {
            case .monday:
                result[0] = "\(otherStrings.monday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .tuesday:
                result[1] = "\(otherStrings.tuesday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .wednesday:
                result[2] = "\(otherStrings.wednesday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .thursday:
                result[3] = "\(otherStrings.thursday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .friday:
                result[4] = "\(otherStrings.friday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .saturday:
                result[5] = "\(otherStrings.saturday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .sunday:
                result[6] = "\(otherStrings.sunday.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            case .publicHolidays:
                result[7] = "\(otherStrings.publicHolidays.rawValue.localized()): " + "\(i.opens)" + "-" + "\(i.closes)"
            }
        }
        return result
    }
}



