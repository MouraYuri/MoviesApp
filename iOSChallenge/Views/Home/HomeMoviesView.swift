//
//  HomeMoviesView.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//

import UIKit

class HomeMoviesView: UIView {
    
    var movies: [Movie] = [] {
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
        obj.allowsSelection = false
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
        cell.setupCell(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height/5
    }
}
