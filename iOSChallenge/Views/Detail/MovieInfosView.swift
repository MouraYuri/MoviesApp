//
//  MovieInfosView.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit

class MovieInfosView: UIView {
    
    lazy var movieTitle: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        obj.textColor = .white
        obj.lineBreakMode = .byWordWrapping
        obj.numberOfLines = 0
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieRating: UILabel = {
        let obj = UILabel()
        obj.textColor = .yellow
        obj.textAlignment = .right
        obj.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var releaseDate: UILabel = {
        let obj = UILabel()
        obj.textColor = .gray
        obj.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        obj.lineBreakMode = .byWordWrapping
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    override func didMoveToSuperview() {
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.addSubview(self.movieTitle)
        self.addSubview(self.movieRating)
        self.addSubview(self.releaseDate)
        
        NSLayoutConstraint.activate([
            self.movieTitle.topAnchor.constraint(equalTo: self.topAnchor),
            self.movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.movieTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            self.movieTitle.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            self.movieRating.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.movieRating.centerYAnchor.constraint(equalTo: self.movieTitle.centerYAnchor),
            self.movieRating.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            self.movieRating.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            self.releaseDate.topAnchor.constraint(equalTo: self.movieRating.bottomAnchor, constant: 8),
            self.releaseDate.trailingAnchor.constraint(equalTo: self.movieRating.trailingAnchor),
            self.releaseDate.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            self.releaseDate.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }

    func setupMovieInfosContent(_ movie: Movie) {
        self.movieTitle.text = movie.title
        self.movieRating.text = self.getMovieRatingText(rating: movie.voteAverage)
        self.releaseDate.text = self.getMovieReleaseDateText(movieReleaseDate: movie.releaseDate)
    }
    
    func getMovieRatingText(rating: Double) -> String {
        let numberOfStars = Int(rating/2)
        var retString = ""
        for _ in 0..<numberOfStars {
            retString.append("⭐")
        }
        return retString == "" ? "⭐" : retString
    }
    
    func getMovieReleaseDateText(movieReleaseDate: String) -> String{
        let retString = "Data de lançamento: " + movieReleaseDate
        return retString
    }
}
