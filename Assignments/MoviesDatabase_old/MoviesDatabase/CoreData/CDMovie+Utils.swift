//
//  CDMovie+Utils.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

extension CDMovie {
    
    func createMovie() -> Movie {
        return Movie(id: Int(id), title: title!, popularity: popularity, vote_average: vote_average, vote_count: 22, release_date: release_date ?? "N/A", poster_path: poster_path, overview: overview!)
      //  return Movie(id: Int(id), title: title!, overview: overview!)
        
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

//"/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"
