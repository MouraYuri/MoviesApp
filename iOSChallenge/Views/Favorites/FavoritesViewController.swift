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
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getFavoritedMovies()
    }
    
    // MARK: Setup UI
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(FavoritesMovieTableViewCell.self, forCellReuseIdentifier: FavoritesMovieTableViewCell.identifier)
    }
    
    func setupViewController() {
        self.title = "Favoritos"
        self.view.backgroundColor = UIColor.mainColor
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setupConstraints() {}

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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let movie = self.favoritesMovies[indexPath.row]
        switch editingStyle {
        case .delete:
            self.tableView.beginUpdates()
            self.viewModel.unfavoriteMovie(movie: movie)
            self.favoritesMovies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        default:
            return
        }
    }
}

extension FavoritesViewController: CouldThrowErrorProtocol, FavoritesViewModelDelegate {
    func didFinishWithError(_ error: Error) {
        // Finish Later...
    }
    
    func didFinishFetching(movies: [MovieEntity]) {
        self.favoritesMovies = movies
    }
}
