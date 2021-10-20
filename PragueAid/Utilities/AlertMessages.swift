//
//  AlertMessages.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 20.10.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation

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
