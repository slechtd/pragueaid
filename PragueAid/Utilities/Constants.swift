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

}


enum AlertMessages: String {
    case oops                       = "Oops, something went wrong"
    case heart                      = "❤️"
    case noPermissions              = "No Location Permissions"
    case restrictedPermissions      = "Restricted Location Permissions"
    case noUserlocation             = "PragueAid has troubles determining your location. Please try again later"
    case notInPrague                = "Looks like you're nowhere near Prague."
    case noPermissionsExplanation   = "PragueAid uses Location data to show you relevant targets nearby. For the best experience, please allow PragueAid access to Location in your iPhone's settings."
    case thisFeature                = "This feature requires acess to your Location. For the best experience, please allow PragueAid access to Location in your iPhone's settings."
    case cannotRate                 = "PragueAid is currently a portfolio project. It hasn't been published to the app store (yet!) and cannot be rated.\nThanks for the support though!"
    
}


enum CustomTexts: String {
    case about = "Hi there!\nThank you for checking out PragueAid.\n\nPowered by Prague OpenData API.\n\nv0.1\n© 2021 Daniel Šlechta"
}




