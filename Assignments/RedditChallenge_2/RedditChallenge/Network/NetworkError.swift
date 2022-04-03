//
//  NetworkError.swift
//  RedditChallenge
//
//  Created by Christian Quicano on 3/31/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case other(Error)
}
