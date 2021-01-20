//
//  FavoritesViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }
    
    func setupViewController() {
        self.title = "Favoritos"
        self.view.backgroundColor = UIColor.mainColor
    }

}
