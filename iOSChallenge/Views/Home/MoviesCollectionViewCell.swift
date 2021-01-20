//
//  MovieCollectionViewCell.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MoviesCollectionViewCell"
    
    var isFavorite: Bool = false
    
    // MARK: UI Components
    
    lazy var moviePosterContainer: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.layer.shadowColor = UIColor.black.cgColor
        obj.layer.shadowOpacity = 0.3
        obj.layer.shadowOffset = .zero
        obj.layer.shadowRadius = 12
        obj.layer.masksToBounds = false
        return obj
    }()
    
    lazy var moviePosterImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 12
        obj.layer.masksToBounds = true
        return obj
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        obj.lineBreakMode = .byTruncatingTail
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var favoriteIndicatorImageView: UIImageView = {
        let obj = UIImageView()
        let img = UIImage(named: "Not-Favorite")?.withRenderingMode(.alwaysTemplate)
        obj.image = img
        obj.tintColor = .red
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieInfosStackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .horizontal
        obj.alignment = .center
        obj.distribution = .fill
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    // MARK: Object Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupConstraints()
        self.setupCell()
    }
    
    // MARK: UI Setup
    
    func setupCell(){
        self.backgroundColor = .clear
    }
    
    func setupCellContent(_ movie: Movie) {
        self.movieTitleLabel.text = movie.title
        self.moviePosterImageView.setImage(path: movie.posterPath)
        self.setFavoriteButtonImage()
    }
    
    func setFavoriteButtonImage(){
        let img = self.isFavorite ? UIImage(named: "Favorite") : UIImage(named: "Not-Favorite")
        self.favoriteIndicatorImageView.setImageAndTint(img, withColor: .red)
    }
    
    func setupConstraints() {
        self.addSubview(moviePosterContainer)
        self.moviePosterContainer.addSubview(moviePosterImageView)
        self.addSubview(self.movieInfosStackView)
        self.movieInfosStackView.addArrangedSubview(self.movieTitleLabel)
        self.movieInfosStackView.addArrangedSubview(self.favoriteIndicatorImageView)
        
        NSLayoutConstraint.activate([
            self.moviePosterImageView.topAnchor.constraint(equalTo: self.moviePosterContainer.topAnchor),
            self.moviePosterImageView.leadingAnchor.constraint(equalTo: self.moviePosterContainer.leadingAnchor),
            self.moviePosterImageView.bottomAnchor.constraint(equalTo: self.moviePosterContainer.bottomAnchor),
            self.moviePosterImageView.trailingAnchor.constraint(equalTo: self.moviePosterContainer.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.moviePosterContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.moviePosterContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.moviePosterContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.moviePosterContainer.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            self.movieInfosStackView.topAnchor.constraint(equalTo: self.moviePosterContainer.bottomAnchor),
            self.movieInfosStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.movieInfosStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.movieInfosStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.favoriteIndicatorImageView.widthAnchor.constraint(equalTo: self.movieInfosStackView.widthAnchor, multiplier: 0.15),
            self.favoriteIndicatorImageView.heightAnchor.constraint(equalTo: self.movieInfosStackView.heightAnchor, multiplier: 0.6)
        ])
    }
    
}
