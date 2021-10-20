//
//  UINavigationController+Ext.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 20.10.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setupAppearance(color: UIColor = .secondarySystemBackground) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
