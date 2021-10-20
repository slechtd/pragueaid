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
        case .filter: return Strings.filterLocations.rawValue.localized()
        case .misc: return Strings.miscellaneous.rawValue.localized()
        }
    }
}


enum MoreTableViewFilterCells: Int, CaseIterable {
    case pharmacies
    case medicalInstitutions
    
    var description: String {
        switch self {
        case .pharmacies: return Strings.pharms.rawValue.localized()
        case .medicalInstitutions: return Strings.medicalInstitutions.rawValue.localized()
        }
    }
    
    var image: String {
        switch self {
        case .pharmacies: return SFSymbols.cross.rawValue
        case .medicalInstitutions: return SFSymbols.bandage.rawValue
        }
    }
}


enum MoreTableViewMiscCells: Int, CaseIterable {
    case lang
    case privacy
    case share
    case about
    
    var description: String {
        switch self {
        case .lang: return Strings.appLanguage.rawValue.localized()
        case .privacy: return Strings.privacyPolicy.rawValue.localized()
        case .share: return Strings.share.rawValue.localized()
        case .about: return Strings.aboutThisApp.rawValue.localized()
        }
    }
    
    var image: String {
        switch self {
        case .lang: return SFSymbols.lang.rawValue
        case .privacy: return SFSymbols.privacy.rawValue
        case .share: return SFSymbols.share.rawValue
        case .about: return SFSymbols.questionmark.rawValue
        }
    }
    
}
