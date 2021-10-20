//
//  Strings.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 20.10.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation

//Raw values not meant to be used as literals - see Localized.strings
enum Strings: String {
    //Titles and navigation:
    case search                 = "search"
    case more                   = "more"
    case searchPlaces           = "searchPlaces"
    //Other:
    case about                  = "about"
    case privacyMessage         = "privacyMessage"
    //TargetVC:
    case cancel                 = "cancel"
    case information            = "information"
    case openingHours           = "openingHours"
    case unavailable            = "unavailable"
    case pharmacyCredentials    = "pharmacyCredentials"
    case lastUpdated            = "lastUpdated"
    //Target:
    case closed                 = "closed"
    case monday                 = "monday"
    case tuesday                = "tuesday"
    case wednesday              = "wednesday"
    case thursday               = "thursday"
    case friday                 = "friday"
    case saturday               = "saturday"
    case sunday                 = "sunday"
    case publicHolidays         = "publicHolidays"
    //MoreVC:
    case filterLocations        = "filterLocations"
    case pharms                 = "pharms"
    case medicalInstitutions    = "medicalInstitutions"
    case miscellaneous          = "miscellaneous"
    case appLanguage            = "appLanguage"
    case privacyPolicy          = "privacyPolicy"
    case share                  = "share"
    case aboutThisApp           = "aboutThisApp"
}
