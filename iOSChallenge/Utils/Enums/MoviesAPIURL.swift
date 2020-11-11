//
//  MoviesAPIURL.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 07/11/20.
//

import Foundation
enum MoviesAPIURL: String {
    case moviesNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=c2e78b4a8c14e65dd6e27504e6df95ad&language=pt-br&region=BR"
    case getMovieImage = "https://image.tmdb.org/t/p/w200"
}
