//
//  InfoSectionCellContent.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 25/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import Foundation

//Used to init PAInfoCell in the information section. Carries data from the given Target.

struct InfoSectionCellContent {
    var action: CellAction
    var textLine1: String
    var textLine2: String?
    var icon: SFSymbols
}

enum CellAction {
    case none
    case address
    case email
    case phone
    case web
    case favorite
}
