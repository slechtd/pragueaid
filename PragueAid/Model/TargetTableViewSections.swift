//
//  TargetTableViewSections.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//


enum TargetTableViewSections: Int, CaseIterable {
    case information
    case openingHours
    case credentials
    
    var description: String {
        switch self {
        case .information: return otherStrings.information.rawValue.localized()
        case .openingHours: return otherStrings.openingHours.rawValue.localized()
        case .credentials: return otherStrings.pharmacyCredentials.rawValue.localized()
        }
    }
}



