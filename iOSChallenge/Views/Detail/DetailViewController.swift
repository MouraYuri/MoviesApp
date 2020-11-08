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
            self.moviePosterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.moviePosterView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.moviePosterView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35),
            self.moviePosterView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45)
        ])
    }
}
