//
//  MoviePosterView.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit
import SDWebImage

class MoviePosterView: UIView {

    lazy var moviePosterImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleToFill
        return obj
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.addSubview(self.moviePosterImageView)
        
        NSLayoutConstraint.activate([
            self.moviePosterImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.moviePosterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.moviePosterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.moviePosterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setMoviePosterImage(_ posterPath: String?) {
        if let posterPath = posterPath {
            let url = URL(string: MoviesAPIURL.getMoviePoster.rawValue + posterPath)
            self.moviePosterImageView.sd_setImage(with: url, completed: nil)
        }
        
    }
}
