//
//  MovieSingle.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/16/22.
//

import Foundation

class MovieProd: Codable {
    
    let productionCompanies: [MovieCompany]
//    let backdropPath: String
    
    
    enum CodingKeys: String, CodingKey {

        case productionCompanies = "production_companies"
//        case backdropPath = "backdrop_path"
        
    }
    
}
    
    
