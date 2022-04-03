//
//  RedditResponseData.swift
//  RedditChallenge
//
//  Created by Christian Quicano on 3/31/22.
//

import Foundation

struct RedditResponseData: Codable {
    let after: String
    let children: [RedditChild]
}
