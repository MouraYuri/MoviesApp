//
//  CustomTabBarController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = self.getArrayOfViewControllers()
        self.tabBar.barTintColor = UIColor.mainColor
    }
    
    private func getArrayOfViewControllers() -> [UIViewController] {
        let homeViewController = HomeViewController()
        let navController1 = UINavigationController(rootViewController: homeViewController)
        homeViewController.tabBarItem.image = UIImage(named: "homeIcon")
        homeViewController.title = "Home"

        let favoritesViewController = FavoritesViewController()
        favoritesViewController.title = "Favoritos"
        favoritesViewController.tabBarItem.image = UIImage(named: "heartIcon")
        let navController2 = UINavigationController(rootViewController: favoritesViewController)
        return [navController1, navController2]
    }

}
