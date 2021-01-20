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
    func didFinishFetchingWithError(_ error: Error)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    var moviesURL = MoviesAPIURL.popularMovies.rawValue
    
    func fetchMovies(page: Int = 1){
        let requestURL = self.moviesURL + "&page=\(page)"
        RequestsManager.shared.makeRequest(to: requestURL, method: .get) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(FetchMoviesResponse.self, from: data)
                    self?.delegate?.didFinishFetching(response)
                } catch {
                    self?.delegate?.didFinishFetchingWithError(error)
                }
            case .failure(let error):
                self?.delegate?.didFinishFetchingWithError(error)
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
            self.delegate?.didFinishFetchingWithError(error)
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
