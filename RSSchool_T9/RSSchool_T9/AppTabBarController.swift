//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/28/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Items", image: UIImage(systemName: "square.grid.2x2", withConfiguration: UIImage.SymbolConfiguration(weight: .medium )), tag: 0)
        
        let navigationController = UINavigationController(rootViewController: SettingsMainViewController())
        navigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), tag: 0)
        
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = UIColor(named: "TabBarUnselected")
        
        self.tabBar.barTintColor = .white
        
        self.viewControllers = [homeViewController, navigationController]
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 22, weight: .medium)], for: .normal)
//        self.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 33, weight: .medium)], for: .selected)
//    }
//
//    override var shouldAutorotate: Bool {
//            if let viewController = self.viewControllers?[self.selectedIndex] {
//                return viewController.shouldAutorotate
//            }
//            return super.shouldAutorotate
//        }
//
//        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//            if let viewController = self.viewControllers?[self.selectedIndex] {
//                return viewController.supportedInterfaceOrientations
//            }
//            return super.supportedInterfaceOrientations
//        }
//
//        override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//            if let viewController = self.viewControllers?[self.selectedIndex] {
//                return viewController.preferredInterfaceOrientationForPresentation
//            }
//            return super.preferredInterfaceOrientationForPresentation
//        }
    
    
}
