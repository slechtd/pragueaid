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
        mapVC.title = "Search Places"
        mapVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: mapVC)
    }
    
    
    func MoreNC() -> UINavigationController {
        let moreVC = MoreVC()
        moreVC.title = "More"
        moreVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        return UINavigationController(rootViewController: moreVC)
    }

}
