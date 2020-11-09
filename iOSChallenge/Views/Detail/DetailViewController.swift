//
//  DetailViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    lazy var movieBackdrop: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var moviePoster: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var movieInfos: MovieInfosView = {
        let obj = MovieInfosView()
        obj.translatesAutoresizingMaskIntoConstraints = false
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
        self.movieBackdrop.setImage(url: .getMovieImage, path: movie.backdropPath)
        self.moviePoster.setImage(url: .getMovieImage, path: movie.posterPath)
        self.movieInfos.setupMovieInfosContent(movie)
    }
    
    func setupConstraints(){
        self.view.addSubview(self.movieBackdrop)
        self.view.addSubview(self.moviePoster)
        self.view.addSubview(self.movieInfos)
        let distanceFromBorders = CGFloat(16)
        
        NSLayoutConstraint.activate([
            self.moviePoster.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: distanceFromBorders),
            self.moviePoster.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: distanceFromBorders),
            self.moviePoster.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35),
            self.moviePoster.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45)
        ])
        
        NSLayoutConstraint.activate([
            self.movieBackdrop.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.movieBackdrop.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.movieBackdrop.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            self.movieInfos.topAnchor.constraint(equalTo: self.moviePoster.bottomAnchor, constant: 4),
            self.movieInfos.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: distanceFromBorders),
            self.movieInfos.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -1*distanceFromBorders),
            self.movieInfos.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25)
        ])
    }
}
