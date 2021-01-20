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
                self.moviesCollectionView.reloadData()
            }
        }
    }
    
    var favoritedMoviesIds: [Int] = [] {
        didSet {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        }
    }

    lazy var moviesCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3)
        layout.scrollDirection = .vertical
        
        let obj = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        obj.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        obj.backgroundColor = .clear
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.delegate = self
        obj.dataSource = self
        return obj
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.addSubview(self.moviesCollectionView)
        
        NSLayoutConstraint.activate([
            self.moviesCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.moviesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.moviesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.moviesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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

extension HomeMoviesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath)
        let movie = self.movies[indexPath.row]
        if let customCell = cell as? MoviesCollectionViewCell {
            customCell.setupCellContent(movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieFavoriteStatus = self.favoritedMoviesIds.contains(movie.id)
        self.delegate?.didSelectAMovie(movie, movieFavoriteStatus: movieFavoriteStatus)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            self.delegate?.didDisplayLastCell(currentPage: self.currentPage)
        }
    }
}
