//
//  FavoriteButton.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 09/11/20.
//

import UIKit

class FavoriteButton: UIButton {
    
    var isFavorite: Bool = false

    lazy var containerView: UIView = {
        let obj = UIView()
        obj.layer.cornerRadius = 12
        obj.backgroundColor = .clear
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.white.cgColor
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var butttonTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.textAlignment = .center
        obj.text = "Favoritar"
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var favoriteImageView: UIImageView = {
        let obj = UIImageView()
        let img = UIImage(named: "Not-Favorite")?.withRenderingMode(.alwaysTemplate)
        obj.image = img
        obj.tintColor = .red
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override func didMoveToSuperview() {
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.butttonTitleLabel)
        self.containerView.addSubview(self.favoriteImageView)
        
        let distanceFromBorders = CGFloat(8)
        
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: distanceFromBorders),
            self.favoriteImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.favoriteImageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.7),
            self.favoriteImageView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.22)
        ])
        
        NSLayoutConstraint.activate([
            self.butttonTitleLabel.leadingAnchor.constraint(equalTo: self.favoriteImageView.trailingAnchor, constant: 4),
            self.butttonTitleLabel.centerYAnchor.constraint(equalTo: self.favoriteImageView.centerYAnchor),
            self.butttonTitleLabel.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.5),
            self.butttonTitleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -1*distanceFromBorders)
        ])
    }

    func didFavorite(){
        let img = UIImage(named: "Favorite")
        img?.withRenderingMode(.alwaysTemplate)
        self.favoriteImageView.image = img
        self.favoriteImageView.tintColor = .red
        self.isFavorite = true
    }
    
    func didUnfavorite(){
        let img = UIImage(named: "Not-Favorite")
        img?.withRenderingMode(.alwaysTemplate)
        self.favoriteImageView.image = img
        self.favoriteImageView.tintColor = .red
        self.isFavorite = false
    }
}
