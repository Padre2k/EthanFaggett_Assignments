//
//  MovieItem.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

struct MovieItem: Codable {
    
    let id: Int
  //  let isFav: Bool
    let title: String
  //  let imageData: Data
  //  let votes: Int
  //  let voteAvg: Double
  //  let popularity: Int
    let isFavorite: Bool
    
}
