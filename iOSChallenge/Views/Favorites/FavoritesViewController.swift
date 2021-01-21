//
//  FavoritesViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    // MARK: Control Variables
    var favoritesMovies = [MovieEntity]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    lazy var viewModel: FavoritesViewModel = { [unowned self] in
        let obj = FavoritesViewModel()
        obj.delegate = self
        return obj
    }()
    
    // MARK: UI Components
    
    // MARK: Object Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
        self.setupConstraints()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getFavoritedMovies()
    }
    
    // MARK: Setup UI
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FavoritesMovieTableViewCell.self, forCellReuseIdentifier: FavoritesMovieTableViewCell.identifier)
    }
    
    func setupViewController() {
        self.title = "Favoritos"
        self.view.backgroundColor = UIColor.mainColor
    }
    
    func setupConstraints() {
    }

}

extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favoritesMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FavoritesMovieTableViewCell.identifier, for: indexPath)
        let movie = self.favoritesMovies[indexPath.row]
        if let customCell = cell as? FavoritesMovieTableViewCell {
            customCell.setupCellContent(movie)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UIScreen.main.bounds.height/5
        }
}

extension FavoritesViewController: CouldThrowErrorProtocol, FavoritesViewModelDelegate {
    func didFinishFetchingWithError(_ error: Error) {
        
    }
    
    func didFinishFetching(movies: [MovieEntity]) {
        self.favoritesMovies = movies
    }
}
