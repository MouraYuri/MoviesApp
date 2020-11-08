//
//  DetailViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    lazy var moviePosterView: MoviePosterView = {
        let obj = MoviePosterView()
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
        self.moviePosterView.setMoviePosterImage(movie.posterPath)
    }
    
    func setupConstraints(){
        self.view.addSubview(self.moviePosterView)
        
        NSLayoutConstraint.activate([
            self.moviePosterView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviePosterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviePosterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviePosterView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.55)
        ])
    }
}
