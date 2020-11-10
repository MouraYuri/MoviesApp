//
//  HomeViewModel.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 06/11/20.
//

import Foundation
import CoreData

protocol HomeViewModelDelegate: class {
    func didFinishFetching(_ response: FetchMoviesResponse)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    var moviesURL = MoviesAPIURL.moviesNowPlaying.rawValue
    
    func fetchMovies(page: Int = 1){
        self.moviesURL += "&page=\(page)"
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
    
    func getFavoritedMovies(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieCoreData")
        do {
            let managedObjectMovies = (try context.fetch(fetchRequest))
            let movies = self.parseManagedObjectToMovie(movies: managedObjectMovies)
            print(movies)
        }catch {
            print(error)
        }
    }
    
    func parseManagedObjectToMovie(movies: [NSManagedObject]) -> [Movie] {
        var retMovies: [Movie] = []
        for movie in movies {
            retMovies.append(Movie(managedObj: movie))
        }
        return retMovies
    }
    
}
