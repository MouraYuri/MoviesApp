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
    
    lazy var moviePosterImageViewContainer: UIView = {
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
    
    lazy var movieTitle: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieReleaseDate: UILabel = {
        let obj = UILabel()
        obj.textColor = .gray
        obj.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
        self.setupCell()
    }
    
    func setupCell(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func setupCellContent(_ movie: Movie) {
        self.movieTitle.text = movie.title
        self.movieRating.text = self.getMovieRatingText(rating: movie.voteAverage)
        if let posterPath = movie.posterPath {
            setMoviePosterImage(posterPath)
        }
        self.movieReleaseDate.text = self.getMovieReleaseDateText(movieReleaseDate: movie.releaseDate)
    }
    
    func setMoviePosterImage(_ posterPath: String) {
        let url = URL(string: MoviesAPIURL.getMoviePoster.rawValue + posterPath)
        self.moviePosterImageView.sd_setImage(with: url, completed: nil)
    }
    
    func getMovieReleaseDateText(movieReleaseDate: String) -> String{
        let retString = "Data de lançamento: " + movieReleaseDate
        return retString
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
        self.contentView.addSubview(self.moviePosterImageViewContainer)
        self.moviePosterImageViewContainer.addSubview(self.moviePosterImageView)
        self.contentView.addSubview(self.movieTitle)
        self.contentView.addSubview(self.movieReleaseDate)
        self.contentView.addSubview(self.movieRating)
        
        let distanceFromMoviePoster = CGFloat(16)
        
        NSLayoutConstraint.activate([
            self.moviePosterImageViewContainer.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.moviePosterImageViewContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.moviePosterImageViewContainer.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8),
            self.moviePosterImageViewContainer.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
        ])
        
        NSLayoutConstraint.activate([
            self.moviePosterImageView.topAnchor.constraint(equalTo: self.moviePosterImageViewContainer.topAnchor),
            self.moviePosterImageView.bottomAnchor.constraint(equalTo: self.moviePosterImageViewContainer.bottomAnchor),
            self.moviePosterImageView.leadingAnchor.constraint(equalTo: self.moviePosterImageViewContainer.leadingAnchor),
            self.moviePosterImageView.trailingAnchor.constraint(equalTo: self.moviePosterImageViewContainer.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.movieTitle.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieTitle.topAnchor.constraint(equalTo: self.moviePosterImageView.topAnchor, constant: 8),
            self.movieTitle.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6),
            self.movieTitle.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            self.movieReleaseDate.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieReleaseDate.centerYAnchor.constraint(equalTo: self.moviePosterImageView.centerYAnchor),
            self.movieReleaseDate.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.85),
            self.movieReleaseDate.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            self.movieRating.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromMoviePoster),
            self.movieRating.bottomAnchor.constraint(equalTo: self.moviePosterImageView.bottomAnchor, constant: -8),
            self.movieRating.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            self.movieRating.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2)
        ])
    }
    
}
