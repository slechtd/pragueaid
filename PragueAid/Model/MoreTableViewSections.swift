//
//  MoreTableViewSections.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 08.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//


enum MoreTableViewSections: Int, CaseIterable {
    case filter
    case misc
    
    var description: String {
        switch self {
        case .filter: return "Filter Locations:"
        case .misc: return "Miscellaneous:"
        }
    }
}


enum MoreTableViewFilterCells: Int, CaseIterable {
    case walkingDistance
    case medicalInstitutions
    case benu
    case drmax
    case teta
    case other
    
    var description: String {
        switch self {
        case .walkingDistance: return "Walking distance only (1km)"
        case .medicalInstitutions: return "Medical institutions"
        case .benu: return "BENU"
        case .drmax: return "Dr.Max"
        case .teta: return "Teta"
        case .other: return "Other pharmacies"
        }
    }
    
    var image: String {
        switch self {
        case .walkingDistance: return SFSymbol.walk.rawValue
        case .medicalInstitutions: return SFSymbol.bandage.rawValue
        case .benu: return SFSymbol.cross.rawValue
        case .drmax: return SFSymbol.cross.rawValue
        case .teta: return SFSymbol.cross.rawValue
        case .other: return SFSymbol.cross.rawValue
        }
    }
}


enum MoreTableViewMiscCells: Int, CaseIterable {
    case lang
    case rate
    case about
    
    var description: String {
        switch self {
        case .lang: return "App language"
        case .rate: return "Rate this app"
        case .about: return "About this app"
        }
    }
    
    var image: String {
        switch self {
        case .lang: return SFSymbol.lang.rawValue
        case .rate: return SFSymbol.star.rawValue
        case .about: return SFSymbol.questionmark.rawValue
        }
    }
    
}
