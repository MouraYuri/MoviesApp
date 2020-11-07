//
//  FetchMovieResponse.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//

import Foundation
struct FetchMoviesResponse: Codable {
    let movies: [Movie]
    let page, totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
