//
//  MarsModel.swift
//  MarsProject
//
//  Created by Ethan Faggett on 3/28/22.
//

import Foundation

struct MarsItem: Decodable {
    
   let photos : [Photos]

}

struct Photos: Decodable {
    let id: Int
    let sol: Int
    let img_src: String
    let earth_date: String
    let camera : Camera
//    let status: Bool
    let rover: Rover
}

struct Rover: Decodable {
    let id: Int
    let name: String
    let landing_date: String
    let launch_date: String
    let status: String
    
}

struct Camera: Decodable {
    let id: Int
    let name: String
    let rover_id: Int
    let full_name: String
}
