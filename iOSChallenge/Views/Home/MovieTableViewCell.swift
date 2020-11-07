//
//  MovieTableViewCell.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {

    static let identifier = "MoviesTableViewCell"
    
    lazy var moviePosterImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    lazy var movieTitle: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieRating: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupConstraints()
        self.backgroundColor = .clear
    }
    
    func setupCell(_ movie: Movie) {
        self.movieTitle.text = movie.title
        self.movieRating.text = self.getMovieRatingText(rating: movie.voteAverage)
        setMoviePosterImage(movie.posterPath)
        
    }
    
    func setMoviePosterImage(_ posterPath: String) {
        let url = URL(string: MoviesAPIURL.getMoviePoster.rawValue + posterPath)
        self.moviePosterImageView.sd_setImage(with: url, completed: nil)
    }
    
    func getMovieRatingText(rating: Double) -> String {
        let numberOfStars = Int(rating/2)
        var retString = ""
        for _ in 0..<numberOfStars {
            retString.append("⭐")
        }
        return retString == "" ? "⭐" : retString
    }
    
    func setupConstraints(){
        self.contentView.addSubview(self.moviePosterImageView)
        self.contentView.addSubview(self.movieTitle)
        self.contentView.addSubview(self.movieRating)
        
        let distanceFromMoviePoster = CGFloat(8)
        
        NSLayoutConstraint.activate([
            self.moviePosterImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.moviePosterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.moviePosterImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8),
            self.moviePosterImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.22),
        ])
        
        NSLayoutConstraint.activate([
            self.movieTitle.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieTitle.topAnchor.constraint(equalTo: self.moviePosterImageView.topAnchor, constant: 8),
            self.movieTitle.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.85),
            self.movieTitle.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            self.movieRating.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieRating.bottomAnchor.constraint(equalTo: self.moviePosterImageView.bottomAnchor, constant: -8),
            self.movieRating.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            self.movieRating.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
    }
    
}
