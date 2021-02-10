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
    case pharmacies
    case medicalInstitutions
    
    var description: String {
        switch self {
        case .pharmacies: return "Pharmacies"
        case .medicalInstitutions: return "Medical institutions"
        }
    }
    
    var image: String {
        switch self {
        case .pharmacies: return SFSymbol.cross.rawValue
        case .medicalInstitutions: return SFSymbol.bandage.rawValue
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
