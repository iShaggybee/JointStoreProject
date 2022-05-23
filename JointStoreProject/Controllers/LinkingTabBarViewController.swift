//
//  LinkingTabBarViewController.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 23.05.2022.
//

import UIKit

protocol LinkingTabBarVCDelegate {
    func changeTabBarItem(on item: TabBarItem)
}

class LinkingTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for viewController in viewControllers ?? [] {
            if let navigationVC = viewController as? UINavigationController {
                if let vc = navigationVC.topViewController as? ProductListViewController {
                    vc.delegate = self
                }
            }
        }
    }
}

extension LinkingTabBarViewController: LinkingTabBarVCDelegate {
    func changeTabBarItem(on item: TabBarItem) {
        selectedIndex = item.rawValue
    }
}
