//
//  FilterSettings.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 09.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation

struct FilterSettings: Codable {
    var walkingDistance: Bool
    var medicalInstitutions: Bool
    var benu: Bool
    var drmax: Bool
    var teta: Bool
    var other: Bool
    
    func getArray() -> [Bool] {
        return [walkingDistance, medicalInstitutions, benu, drmax, teta, other]
    }
}


