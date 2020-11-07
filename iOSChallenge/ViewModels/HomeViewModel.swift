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
    
    let moviesURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language=pt-br&page=1"
    
    func fetchMovies(){
        Services.shared.makeRequest(to: moviesURL, method: .get) { [weak self] (data, error) in
            guard let data = data else { return }
            do {
                let decodable = JSONDecoder()
                let response = try decodable.decode(FetchMoviesResponse.self, from: data)
                self?.delegate?.didFinishFetching(response)
            } catch {
                print(error)
            }
        }
    }
}
