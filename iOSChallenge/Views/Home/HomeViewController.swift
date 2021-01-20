//
//  HomeViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 06/11/20.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    
    lazy var viewModel: HomeViewModel = { [unowned self] in
        let obj = HomeViewModel()
        obj.delegate = self
        return obj
    }()
    
    lazy var homeMoviesView: HomeMoviesView = { [unowned self] in
        let obj = HomeMoviesView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.delegate = self
        return obj
    }()
    
    lazy var loadingIndicatorView: NVActivityIndicatorView = {
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let obj = NVActivityIndicatorView(frame: rect, type: .cubeTransition, color: UIColor.white, padding: nil)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConstraints()
        self.setupViewController()
        self.loadingIndicatorView.startAnimating()
        self.viewModel.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getFavoritedMovies()
    }
    
    func setupViewController(){
        self.view.backgroundColor = UIColor.mainColor
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setupConstraints() {
        self.view.addSubview(self.homeMoviesView)
        self.view.addSubview(self.loadingIndicatorView)
        
        NSLayoutConstraint.activate([
            self.homeMoviesView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.homeMoviesView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.93),
            self.homeMoviesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.homeMoviesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func didFinishFetchingWithError(_ error: Error) {
        self.loadingIndicatorView.stopAnimating()
    }
    
    func didFinishFetchingFavoritedMoviesIDs(_ favoritedMoviesIDs: [Int]) {
        self.homeMoviesView.favoritedMoviesIds = favoritedMoviesIDs
    }
    
    func didFinishFetching(_ response: FetchMoviesResponse) {
        DispatchQueue.main.async {
            self.loadingIndicatorView.stopAnimating()
        }
        self.homeMoviesView.setMovies(page: response.page, movies: response.movies)
        self.homeMoviesView.currentPage = response.page
    }
}

extension HomeViewController: HomeMoviesViewDelegate {
    func didDisplayLastCell(currentPage: Int) {
        self.viewModel.fetchMovies(page: currentPage+1)
    }
    
    func didSelectAMovie(_ movie: Movie, movieFavoriteStatus: Bool) {
        let detailViewController = DetailViewController(movie, movieFavoriteStatus: movieFavoriteStatus)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
