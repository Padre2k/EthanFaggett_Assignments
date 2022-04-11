//
//  MovieResponse.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

struct MovieResponse: Codable {
    
    //let page: Int
    let movie: [Movie]
    //let totalPages: Int
    //let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
    
      //  case page
        case movie = "results"
       // case totalPages = "total_pages"
        //case totalResults = "total_results"
    }
    
  //  let data: MovieResponseData
}
