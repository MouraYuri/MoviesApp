//
//  FavoriteButton.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 09/11/20.
//

import UIKit

class FavoriteButton: UIButton {
    
    var isFavorite: Bool = false {
        didSet {
            self.isFavorite == true ? self.didFavorite() : self.didUnfavorite()
        }
    }

    lazy var containerButton: UIButton = {
        let obj = UIButton()
        obj.layer.cornerRadius = 12
        obj.backgroundColor = .clear
        obj.layer.borderWidth = 2
        obj.layer.borderColor = UIColor.white.cgColor
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    lazy var butttonTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.textAlignment = .center
        obj.text = "Favoritar"
        obj.font = UIFont.systemFont(ofSize: 18)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    lazy var favoriteImageView: UIImageView = {
        let obj = UIImageView()
        let img = UIImage(named: "Not-Favorite")?.withRenderingMode(.alwaysTemplate)
        obj.image = img
        obj.tintColor = .red
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    override func didMoveToSuperview() {
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.addSubview(self.butttonTitleLabel)
        self.addSubview(self.favoriteImageView)
        self.addSubview(self.containerButton)
        
        let distanceFromBorders = CGFloat(8)
        
        NSLayoutConstraint.activate([
            self.containerButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteImageView.leadingAnchor.constraint(equalTo: self.containerButton.leadingAnchor, constant: distanceFromBorders),
            self.favoriteImageView.centerYAnchor.constraint(equalTo: self.containerButton.centerYAnchor),
            self.favoriteImageView.heightAnchor.constraint(equalTo: self.containerButton.heightAnchor, multiplier: 0.7),
            self.favoriteImageView.widthAnchor.constraint(equalTo: self.containerButton.widthAnchor, multiplier: 0.22)
        ])
        
        NSLayoutConstraint.activate([
            self.butttonTitleLabel.leadingAnchor.constraint(equalTo: self.favoriteImageView.trailingAnchor, constant: 2),
            self.butttonTitleLabel.centerYAnchor.constraint(equalTo: self.favoriteImageView.centerYAnchor),
            self.butttonTitleLabel.heightAnchor.constraint(equalTo: self.containerButton.heightAnchor, multiplier: 0.5),
            self.butttonTitleLabel.trailingAnchor.constraint(equalTo: self.containerButton.trailingAnchor, constant: -1*distanceFromBorders)
        ])
    }

    func didFavorite(){
        let img = UIImage(named: "Favorite")?.withRenderingMode(.alwaysTemplate)
        self.favoriteImageView.image = img
        self.favoriteImageView.tintColor = .red
        self.butttonTitleLabel.text = "Favorito"
    }
    
    func didUnfavorite(){
        let img = UIImage(named: "Not-Favorite")?.withRenderingMode(.alwaysTemplate)
        self.favoriteImageView.image = img
        self.favoriteImageView.tintColor = .red
        self.butttonTitleLabel.text = "Favoritar"
    }
    
    func changeButtonInterface(favoriteStatus: Bool){
        self.isFavorite = favoriteStatus
    }
    
    func addTouchTarget(_ viewController: UIViewController, selector: Selector) {
        self.containerButton.addTarget(viewController, action: selector, for: .touchUpInside)
    }
}
