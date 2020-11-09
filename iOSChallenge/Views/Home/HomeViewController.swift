//
//  HomeViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 06/11/20.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConstraints()
        self.setupViewController()
    }
    
    func setupViewController(){
        self.view.backgroundColor = UIColor(named: "MAIN_COLOR")
        self.title = "Home"
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MAIN_COLOR")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchMovies()
    }
    
    func setupConstraints() {
        self.view.addSubview(self.homeMoviesView)
        
        NSLayoutConstraint.activate([
            self.homeMoviesView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.homeMoviesView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            self.homeMoviesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.homeMoviesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

}

extension HomeViewController: HomeViewModelDelegate {
    func didFinishFetching(_ response: FetchMoviesResponse) {
        if response.page == 1 {
            self.homeMoviesView.movies = response.movies
        } else {
            self.homeMoviesView.movies.append(contentsOf: response.movies)
        }
        self.homeMoviesView.currentPage = response.page
    }
}

extension HomeViewController: HomeMoviesViewDelegate {
    func didDisplayLastCell(currentPage: Int) {
        self.viewModel.fetchMovies(page: currentPage+1)
    }
    
    func didSelectAFilm(movie: Movie) {
        let detailViewController = DetailViewController()
        detailViewController.setupViewControllerContent(movie: movie)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
