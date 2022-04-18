//
//  NetworkURLs.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

enum NetworkURLs {
    
    static let urlBase = "https://api.themoviedb.org/3"
    
    static let urlMoviesPopular = "\(urlBase)/movie/popular?\(apiKey)&\(languageKey)"
    static let apiKey = "api_key=6622998c4ceac172a976a1136b204df4"
    static let languageKey = "language=en-US"
    
    static let urlPhotoBase = "https://image.tmdb.org/t/p/w500"
}

