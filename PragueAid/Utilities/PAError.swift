//
//  PAError.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

enum PAError: String, Error {
    case invalidURL                     = "Invalid URL."
    case unableToComplete               = "Unable to complete request."
    case invalidResponse                = "Invalid response."
    case invalidData                    = "Invalid data in response."
    case unableToDecode                 = "Unable to decode data in response."
    case unableToLoadFilterSettings     = "Unable to load filter settings."
    case unableToSaveFilterSettings     = "Unable to save filter settings."
}
