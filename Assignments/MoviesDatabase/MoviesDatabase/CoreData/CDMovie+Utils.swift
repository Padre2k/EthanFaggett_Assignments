//
//  CDMovie+Utils.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

extension CDMovie {
    
    func createMovie() -> Movie {
        return Movie(id: Int(id), title: title!, popularity: 22.2, vote_average: 77.0, vote_count: 22, release_date: release_date!, poster_path: poster_path!, overview: overview!)
    }
    
}


//case id
//case title
//case popularity
//case vote_average
//case vote_count
//case release_date
//case poster_path
//case overview
