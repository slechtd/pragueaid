//
//  UITabBarController+Ext.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 20.10.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarController {
    
    func setupAppearance(color: UIColor = .secondarySystemBackground, tint: UIColor = .systemRed){
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = color
            self.tabBar.standardAppearance = tabBarAppearance
            self.tabBar.tintColor = tint

            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = tabBarAppearance
                self.tabBar.tintColor = tint
            }
        }
    }
}
