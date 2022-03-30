//
//  MarsItemAux.swift
//  MarsProject
//
//  Created by Ethan Faggett on 3/29/22.
//

import Foundation

struct MarsItemAux: Decodable {
    
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    var status : Bool
    
}
