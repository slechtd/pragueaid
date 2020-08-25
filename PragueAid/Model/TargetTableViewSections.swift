//
//  TargetTableViewSections.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//


enum TargetTableViewSections: Int, CaseIterable/*, CustomStringConvertible*/ {
    case information
    case openingHours
    case credentials
    
    var description: String {
        switch self {
        case .information: return "Information:"
        case .openingHours: return "Opening Hours:"
        case .credentials: return "Pharmacy Credentials:"
        }
    }
}



