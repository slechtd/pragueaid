//
//  PAError.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

#warning("better string messages")
enum PAError: String, Error {
    case invalidURL         = "invalidURL"
    case unableToComplete   = "unableToComplete"
    case invalidResponse    = "invalidResponse"
    case invalidData        = "invalidData"
    case unableToDecode     = "unableToDecode"
    case unableToLoadFilterSettings = "unableToLoadFilterSettings"
    case unableToSaveFilterSettings = "unableToSaveFilterSettings"
}
