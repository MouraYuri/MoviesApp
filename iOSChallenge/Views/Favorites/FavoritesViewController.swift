//
//  FavoritesViewController.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    // MARK: Control Variables
    var favoritesMovies = [Movie]()
    
    // MARK: UI Components
    
    // MARK: Object Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
        self.setupConstraints()
        self.setupTableView()
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
}
