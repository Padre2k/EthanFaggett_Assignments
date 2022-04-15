//
//  Movie.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

struct Results: Codable {
    let results: [Movie]
}

//struct Movie: Codable {
//    
//    let id: Int
//    let title: String
//    let overview: String
//   // let popularity: Decimal
//
//}



struct Movie: Codable {
    
    let id: Int
    let title: String
    let popularity: Double?
    let vote_average: Double?
    let vote_count: Int
    let release_date: String
    let poster_path: String?
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case popularity
        case vote_average
        case vote_count
        case release_date
        case poster_path
        case overview
        
    }
    
}






//struct Movie: Codable {
//
//    let title: String?
//    let thumbnail: String?
//    let score: Int?
//    let numComments: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case thumbnail
//        case score
//        case numComments = "num_comments"
//    }
//}


