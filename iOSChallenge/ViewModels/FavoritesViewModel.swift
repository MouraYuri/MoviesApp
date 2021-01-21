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
    
    func unfavoriteMovie(movie: MovieEntity) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        request.predicate = NSPredicate.init(format: "id==\(movie.id)")
        do {
            let moviesManagedObjectsArray = try context.fetch(request)
            guard let movieManagedObject = moviesManagedObjectsArray.first else {
                return
            }
            context.delete(movieManagedObject)
            try context.save()
        } catch {
            print(error)
        }
    }
}
