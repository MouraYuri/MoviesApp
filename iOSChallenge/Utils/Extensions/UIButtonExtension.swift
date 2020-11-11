//
//  UIButtonExtension.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 10/11/20.
//

import Foundation
import UIKit

extension UIButton {
    func setImageAndTint(_ img: UIImage?, withColor color:UIColor) {
        self.setImage(img?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = color
    }
}
