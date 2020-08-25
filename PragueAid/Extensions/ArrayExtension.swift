//
//  ArrayExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 24/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

extension Array {
    func getSanitizedElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}
