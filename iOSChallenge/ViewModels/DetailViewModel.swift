//
//  DetailViewModel.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 10/11/20.
//

import Foundation
import CoreData

class DetailViewModel {
    
    // MARK: Functions
    func favoriteMovie(movie: Movie) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if let _ = movie.parseToMovieEntityAndInsert(into: context) {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func unfavoriteMovie(movie: Movie) {
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
