//
//  MovieFav.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/14/22.
//

import Foundation


struct MovieFav: Codable {
    
    let id: Int
    let title: String
    let popularity: Double?
    let vote_average: Double?
    let vote_count: Int
    let release_date: String
    let poster_path: String?
    let overview: String
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case popularity
        case vote_average
        case vote_count
        case release_date
        case poster_path
        case overview
        case isFavorite
        
    }
    
}
