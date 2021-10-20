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
        case .information: return Strings.information.rawValue.localized()
        case .openingHours: return Strings.openingHours.rawValue.localized()
        case .credentials: return Strings.pharmacyCredentials.rawValue.localized()
        }
    }
}



