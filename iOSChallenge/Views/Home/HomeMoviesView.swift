//
//  HomeMoviesView.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//

import UIKit

protocol HomeMoviesViewDelegate: class {
    func didDisplayLastCell(currentPage: Int)
    func didSelectAMovie(_ movie: Movie, movieFavoriteStatus: Bool)
}

class HomeMoviesView: UIView {
    
    weak var delegate: HomeMoviesViewDelegate?
    
    var currentPage = 1
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    var favoritedMoviesIds: [Int] = [] {
        didSet {
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }

    lazy var moviesTableView: UITableView = { [unowned self] in
        let obj = UITableView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.delegate = self
        obj.dataSource = self
        obj.backgroundColor = .clear
        obj.separatorStyle = .none
        obj.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        return obj
    }()

    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.addSubview(self.moviesTableView)
        
        NSLayoutConstraint.activate([
            self.moviesTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.moviesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.moviesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.moviesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setMovies(page: Int, movies: [Movie]) {
        if page == 1 {
            self.movies = movies
        } else {
            self.movies.append(contentsOf: movies)
        }
    }
}

extension HomeMoviesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.moviesTableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        let movie = self.movies[indexPath.row]
        cell.isFavorite = self.favoritedMoviesIds.contains(movie.id)
        cell.setupCellContent(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height/5
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            self.delegate?.didDisplayLastCell(currentPage: self.currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieFavoriteStatus = self.favoritedMoviesIds.contains(movie.id)
        self.delegate?.didSelectAMovie(movie, movieFavoriteStatus: movieFavoriteStatus)
    }
}
