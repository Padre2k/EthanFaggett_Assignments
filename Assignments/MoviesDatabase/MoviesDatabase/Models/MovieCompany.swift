//
//  Company.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/17/22.
//

import Foundation

struct MovieCompany: Codable {
    
    let id: Int
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {

        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"

    }

    
}








