//
//  Movie.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//
import CoreData

import Foundation
struct Movie: Codable {
    let posterPath: String
    let id: Int
    let backdropPath: String
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(managedObj: NSManagedObject) {
        self.title = managedObj.value(forKey: "title") as? String ?? "An error has ocurred"
        self.voteAverage = managedObj.value(forKey: "voteAverage") as? Double ?? 0.0
        self.releaseDate = managedObj.value(forKey: "releaseDate") as? String ?? "An error has ocurred"
        self.id = managedObj.value(forKey: "id") as? Int ?? 0
        self.overview = managedObj.value(forKey: "overview") as? String ?? "An error has ocurred"
        self.posterPath = managedObj.value(forKey: "posterPath") as? String ?? "An error has ocurred"
        self.backdropPath = managedObj.value(forKey: "backdropPath") as? String ?? "An error has ocurred"
    }
}
