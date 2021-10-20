//
//  PATabBarController.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

class PATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAppearance()
        viewControllers = [MapNC(), MoreNC()]
    }
    
    
    private func MapNC() -> UINavigationController {
        let mapVC = MapVC()
        mapVC.title = otherStrings.searchPlaces.rawValue.localized()
        mapVC.tabBarItem = UITabBarItem(title: otherStrings.search.rawValue.localized(), image: UIImage(systemName: SFSymbol.map.rawValue), selectedImage: UIImage(systemName: SFSymbol.mapFill.rawValue))
        let nc = UINavigationController(rootViewController: mapVC)
        nc.setupAppearance()
        return nc
    }
    
    
    private func MoreNC() -> UINavigationController {
        let moreVC = MoreVC()
        moreVC.title = otherStrings.more.rawValue.localized()
        moreVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        let nc = UINavigationController(rootViewController: moreVC)
        nc.setupAppearance()
        return nc
    }
}
