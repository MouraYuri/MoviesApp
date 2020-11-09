//
//  DetailViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    lazy var movieBackdropImageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var moviePosterImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieInfosView: MovieInfosView = {
        let obj = MovieInfosView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var synopsisTextView: UITextView = {
        let obj = UITextView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        obj.backgroundColor = .clear
        obj.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
        self.setupConstraints()
    }
    
    func setupViewController(){
        self.view.backgroundColor = UIColor(named: "MAIN_COLOR")
        self.title = "Detalhes"
    }
    
    func setupViewControllerContent(movie: Movie){
        self.movieBackdropImageView.setImage(url: .getMovieImage, path: movie.backdropPath)
        self.moviePosterImageView.setImage(url: .getMovieImage, path: movie.posterPath)
        self.movieInfosView.setupMovieInfosContent(movie)
        self.synopsisTextView.text = movie.overview
    }
    
    func setupConstraints(){
        self.view.addSubview(self.movieBackdropImageView)
        self.view.addSubview(self.moviePosterImageView)
        self.view.addSubview(self.movieInfosView)
        self.view.addSubview(self.synopsisTextView)
        let distanceFromBorders = CGFloat(16)
        
        NSLayoutConstraint.activate([
            self.moviePosterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: distanceFromBorders),
            self.moviePosterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: distanceFromBorders),
            self.moviePosterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35),
            self.moviePosterImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45)
        ])
        
        NSLayoutConstraint.activate([
            self.movieBackdropImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.movieBackdropImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.movieBackdropImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            self.movieInfosView.topAnchor.constraint(equalTo: self.moviePosterImageView.bottomAnchor, constant: 4),
            self.movieInfosView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: distanceFromBorders),
            self.movieInfosView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -1*distanceFromBorders),
            self.movieInfosView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            self.synopsisTextView.topAnchor.constraint(equalTo: self.movieInfosView.bottomAnchor),
            self.synopsisTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: distanceFromBorders),
            self.synopsisTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -1*distanceFromBorders),
            self.synopsisTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
