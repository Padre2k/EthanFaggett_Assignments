//
//  NetworkError.swift
//  MarsProject
//
//  Created by Ethan Faggett on 3/28/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badDecode
    case other(Error)
}
