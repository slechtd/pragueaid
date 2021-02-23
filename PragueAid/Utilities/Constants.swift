//
//  Constants.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 16/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//


enum SFSymbol: String {
    case nav            = "location"
    case map            = "map"
    case mapFill        = "map.fill"
    case star           = "star"
    case phone          = "phone"
    case bandage        = "bandage.fill"
    case unavailable    = "exclamationmark"
    case chevron        = "chevron.compact.right"
    case questionmark   = "questionmark"
    case address        = "mappin"
    case email          = "envelope"
    case web            = "globe"
    case cross          = "cross"
    case lang           = "captions.bubble"
    case privacy        = "person"

}


//MARK: - Localized strings

//Raw values not meant to be used as literals - see Localized.strings
enum AlertMessages: String {
    case oops                       = "oops"
    case heart                      = "heart"
    case connection                 = "connection"
    case noPermissions              = "noPermissions"
    case restrictedPermissions      = "restrictedPermissions"
    case noUserlocation             = "noUserlocation"
    case notInPrague                = "notInPrague"
    case noInternet                 = "noInternet"
}

//Raw values not meant to be used as literals - see Localized.strings
enum otherStrings: String {
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
    case aboutThisApp           = "aboutThisApp"
}

