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
        UITabBar.appearance().tintColor = .systemRed
        viewControllers                 = [MapNC(), MoreNC()]
    }
    
    
    func MapNC() -> UINavigationController {
        let mapVC = MapVC()
        mapVC.title = otherStrings.searchPlaces.rawValue.localized()
        mapVC.tabBarItem = UITabBarItem(title: otherStrings.search.rawValue.localized(), image: UIImage(systemName: SFSymbol.map.rawValue), selectedImage: UIImage(systemName: SFSymbol.mapFill.rawValue))
        return UINavigationController(rootViewController: mapVC)
    }
    
    
    func MoreNC() -> UINavigationController {
        let moreVC = MoreVC()
        moreVC.title = otherStrings.more.rawValue.localized()
        moreVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        return UINavigationController(rootViewController: moreVC)
    }

}
