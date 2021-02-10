//
//  FilterSettings.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 09.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation

struct FilterSettings: Codable {
    var pharmacies: Bool
    var medicalInstitutions: Bool
    
    func getArray() -> [Bool] {
        return [pharmacies, medicalInstitutions]
    }
}


