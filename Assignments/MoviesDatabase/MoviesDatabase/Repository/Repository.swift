//
//  Repository.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation


class Repository: RepositoryProtocol {
    
    
    let remote: RemoteRepositoryProtocol
    let local: LocalRepositoryProtocol
    
    init(remote: RemoteRepositoryProtocol, local: LocalRepositoryProtocol) {
        self.remote = remote
        self.local = local
    }
    
    func getMovieCompany(companyID: String, completionHandler: @escaping (Result<MovieProd, NetworkError>) -> Void) {
        remote.getMovieCompany(companyID: companyID, completionHandler: completionHandler)
    }
    
    func getMovies(from url: String, _ completionHandler: @escaping (Result<SuccessResponse, NetworkError>) -> Void) {
        remote.getMovies(from: url, completionHandler)
    }
    
    func getData(from url: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        remote.getData(from: url, completionHandler: completionHandler)
    }
    
    func getMovies() -> [Movie] {
        local.getMovies()
    }
    
    func saveMovies(_ movies: [Movie]) {
        local.saveMovies(movies)
    }
    
    func removeAllMovies() {
        local.removeAllMovies()
    }
    
}
