//
//  FavoritesMovieTableViewCell.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import UIKit
import SDWebImage

class FavoritesMovieTableViewCell: UITableViewCell {

    static let identifier = "FavoritesMovieTableViewCell"
    
    var isFavorite: Bool = false
    
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
        obj.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieReleaseDateLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .gray
        obj.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieRatingLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupConstraints()
        self.setupCell()
    }
    
    func setupCell(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func setupCellContent(_ movie: MovieEntity) {
        self.movieTitleLabel.text = movie.title
        self.movieRatingLabel.text = self.getMovieRatingText(rating: movie.voteAverage)
        self.moviePosterImageView.setImage(path: movie.posterPath)
        self.movieReleaseDateLabel.text = self.getMovieReleaseDateText(movieReleaseDate: movie.releaseDate)
    }
    
    func getMovieReleaseDateText(movieReleaseDate: String?) -> String? {
        guard let releaseDate = movieReleaseDate else {
            return nil
        }
        let retString = "Data de lançamento: " + releaseDate
        return retString
    }
    
    func getMovieRatingText(rating: Double) -> String {
        let numberOfStars = Int(rating/2)
        var retString = ""
        for _ in 0..<numberOfStars { retString.append("⭐") }
        return retString.isEmpty ? "⭐" : retString
    }
    
    func setupConstraints(){
        self.contentView.addSubview(self.moviePosterContainer)
        self.moviePosterContainer.addSubview(self.moviePosterImageView)
        self.contentView.addSubview(self.movieTitleLabel)
        self.contentView.addSubview(self.movieReleaseDateLabel)
        self.contentView.addSubview(self.movieRatingLabel)
        
        let distanceFromMoviePoster = CGFloat(16)
        
        NSLayoutConstraint.activate([
            self.moviePosterContainer.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.moviePosterContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.moviePosterContainer.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8),
            self.moviePosterContainer.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
        ])
        
        NSLayoutConstraint.activate([
            self.moviePosterImageView.topAnchor.constraint(equalTo: self.moviePosterContainer.topAnchor),
            self.moviePosterImageView.bottomAnchor.constraint(equalTo: self.moviePosterContainer.bottomAnchor),
            self.moviePosterImageView.leadingAnchor.constraint(equalTo: self.moviePosterContainer.leadingAnchor),
            self.moviePosterImageView.trailingAnchor.constraint(equalTo: self.moviePosterContainer.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.movieTitleLabel.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieTitleLabel.topAnchor.constraint(equalTo: self.moviePosterImageView.topAnchor, constant: 8),
            self.movieTitleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6),
            self.movieTitleLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            self.movieReleaseDateLabel.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieReleaseDateLabel.centerYAnchor.constraint(equalTo: self.moviePosterImageView.centerYAnchor),
            self.movieReleaseDateLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.85),
            self.movieReleaseDateLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            self.movieRatingLabel.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieRatingLabel.bottomAnchor.constraint(equalTo: self.moviePosterImageView.bottomAnchor, constant: -8),
            self.movieRatingLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            self.movieRatingLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
    }
    
}
