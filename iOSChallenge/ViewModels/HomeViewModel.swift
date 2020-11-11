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
    func didFinishFetchingFavoritedMoviesIDs(_ favoritedMoviesIDs: [Int])
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    var moviesURL = MoviesAPIURL.moviesNowPlaying.rawValue
    
    func fetchMovies(page: Int = 1){
        let requestURL = self.moviesURL + "&page=\(page)"
        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { [weak self] (data, error) in
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
            let managedObjectMovies = try context.fetch(fetchRequest)
            let favoritedMoviesIDs = self.parseManagedObjectsToMoviesIDs(managedObjects: managedObjectMovies)
            self.delegate?.didFinishFetchingFavoritedMoviesIDs(favoritedMoviesIDs)
        }catch {
            print(error)
        }
    }
    
    func parseManagedObjectsToMoviesIDs(managedObjects: [NSManagedObject]) -> [Int] {
        var idArray: [Int] = []
        for managedObject in managedObjects {
            if let id = managedObject.value(forKey: "id") as? Int {
                idArray.append(id)
            }
        }
        return idArray
    }
    
}
