//
//  DetailViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 08/11/20.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    let viewModel = DetailViewModel()
    
    let movie: Movie
    
    var isFavorite: Bool
    
    init(_ movie: Movie, movieFavoriteStatus: Bool) {
        self.movie = movie
        self.isFavorite = movieFavoriteStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    lazy var favoriteButton: FavoriteButton = { [unowned self] in
        let obj = FavoriteButton()
        obj.addTouchTarget(self, selector: #selector(didPressFavoriteButton(sender:)))
        obj.changeButtonInterface(favoriteStatus: self.isFavorite)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.isUserInteractionEnabled = true
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
        self.setupViewControllerContent(movie: movie)
        self.setupViewController()
        self.setupConstraints()
    }
    
    
    func setupViewController(){
        self.view.backgroundColor = UIColor(named: "MAIN_COLOR")
        self.title = "Detalhes"
        self.movieBackdropImageView.isHidden = self.movie.backdropPath == nil ? true : false
    }
    
    func setupViewControllerContent(movie: Movie){
        self.movieBackdropImageView.setImage(path: movie.backdropPath)
        self.moviePosterImageView.setImage(path: movie.posterPath)
        self.movieInfosView.setupMovieInfosContent(movie)
        self.synopsisTextView.text = getSynopsisText(from: movie)
    }
    
    func setupConstraints(){
        self.view.addSubview(self.movieBackdropImageView)
        self.view.addSubview(self.moviePosterImageView)
        self.view.addSubview(self.favoriteButton)
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
            self.favoriteButton.leadingAnchor.constraint(equalTo: self.moviePosterImageView.trailingAnchor, constant: distanceFromBorders),
            self.favoriteButton.bottomAnchor.constraint(equalTo: self.moviePosterImageView.bottomAnchor, constant: -8),
            self.favoriteButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.07),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -1*distanceFromBorders)
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
    
    @objc func didPressFavoriteButton(sender: FavoriteButton){
        self.isFavorite = !(self.isFavorite)
        self.favoriteButton.changeButtonInterface(favoriteStatus: self.isFavorite)
        self.isFavorite ? self.viewModel.favoriteMovie(movie: self.movie) : self.viewModel.unfavoriteMovie(movie: self.movie)
        
    }
    
    func getSynopsisText(from movie: Movie) -> String {
        return movie.overview == "" ? "Sinopse não disponível." : movie.overview
    }
}
