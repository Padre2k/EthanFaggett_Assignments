//
//  MovieResponseAux.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/14/22.
//

import Foundation


struct MovieResponseAux {
    
    let movie: [Movie]
    let dictionary:[String:Int] = [String:Int]()
    
    enum CodingKeys: String, CodingKey {
    
        case movie = "results"
        case dictionary
    }
    
}
