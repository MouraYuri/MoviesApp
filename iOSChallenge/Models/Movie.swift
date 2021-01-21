//
//  Movie.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//
import CoreData
import Foundation

struct Movie: Codable {
    let posterPath: String?
    let id: Int
    let backdropPath: String?
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
    
    func parseToMovieEntityAndInsert(into context: NSManagedObjectContext) -> MovieEntity? {
        if let movieEntity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context) {
            let movieParsed = MovieEntity(entity: movieEntity, insertInto: context)
            movieParsed.id = Int32(self.id)
            movieParsed.title = self.title
            movieParsed.overview = self.overview
            movieParsed.releaseDate = self.releaseDate
            movieParsed.voteAverage = self.voteAverage
            movieParsed.posterPath = posterPath
            return movieParsed
        }
        return nil
    }
}
