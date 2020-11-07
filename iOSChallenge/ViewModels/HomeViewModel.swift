//
//  HomeViewModel.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 06/11/20.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func didFinishFetching(_ response: FetchMoviesResponse)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    let moviesURL = MoviesAPIURL.moviesNowPlaying.rawValue
    
    func fetchMovies(){
        Services.shared.makeRequest(to: moviesURL, method: .get) { [weak self] (data, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(FetchMoviesResponse.self, from: data)
                self?.delegate?.didFinishFetching(response)
            } catch {
                print(error)
            }
        }
    }
}
