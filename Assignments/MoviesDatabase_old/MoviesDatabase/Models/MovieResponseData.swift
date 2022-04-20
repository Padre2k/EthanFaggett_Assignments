//
//  MovieResponseData.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

struct MovieResponseData: Codable {
    let after: String
    let children: [MovieChild]
}
