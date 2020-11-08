//
//  MovieInfosView.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit

class MovieInfosView: UIView {
    
    lazy var movieRating: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var releaseDate: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var originalLanguage: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    override func didMoveToSuperview() {
        self.didMoveToSuperview()
//        self.setupConstraints()
    }

}
