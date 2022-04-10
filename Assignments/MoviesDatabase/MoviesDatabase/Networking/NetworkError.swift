//
//  NetworkError.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case other(Error)
}
