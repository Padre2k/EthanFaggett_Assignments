//
//  Story.swift
//  RedditChallenge
//
//  Created by Christian Quicano on 3/31/22.
//

import Foundation

struct Story: Codable {
    
    let title: String?
//    let thumbnail: String?
    let thumbnail: String?
    let score: Int?
    let numComments: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case thumbnail
      //  case thumbnail =  "url_overridden_by_dest"
        case score
        case numComments = "num_comments"
    }
}
