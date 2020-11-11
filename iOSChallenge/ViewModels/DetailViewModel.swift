//
//  DetailViewModel.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 10/11/20.
//

import Foundation
import CoreData

class DetailViewModel {
    
    func favoriteMovie(movie: Movie) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        if let movieEntity = NSEntityDescription.entity(forEntityName: "MovieCoreData", in: context) {
            let movieManagedObject = NSManagedObject(entity: movieEntity, insertInto: context)
            movieManagedObject.setValue(movie.id, forKey: "id")
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
