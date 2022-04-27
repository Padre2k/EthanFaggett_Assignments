//
//  NetworkError.swift
//  PocketMonster
//
//  Created by Ethan Faggett on 4/27/22.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case other(Error)
}
