//
//  UIImageViewExtension.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImage(url: MoviesAPIURL, path: String?) {
        if let path = path {
            let url = URL(string: MoviesAPIURL.getMovieImage.rawValue + path)
            self.sd_setImage(with: url, completed: nil)
        }
    }
}
