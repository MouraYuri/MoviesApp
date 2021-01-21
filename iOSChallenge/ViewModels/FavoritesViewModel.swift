//
//  FavoritesViewModel.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import Foundation
import CoreData

protocol FavoritesViewModelDelegate: class {
    func didFinishFetching(movies: [MovieEntity])
}

class FavoritesViewModel {
    
    weak var delegate: (FavoritesViewModelDelegate & CouldThrowErrorProtocol)?
    
    // MARK: Functions
    
    func getFavoritedMovies(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        do {
            let movies = try context.fetch(fetchRequest)
            self.delegate?.didFinishFetching(movies: movies)
        }catch {
            self.delegate?.didFinishFetchingWithError(error)
        }
    }
}
