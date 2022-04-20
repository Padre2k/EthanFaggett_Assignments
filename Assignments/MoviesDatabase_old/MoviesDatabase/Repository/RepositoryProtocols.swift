//
//  RepositoryProtocols.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation


protocol RepositoryProtocol: RemoteRepositoryProtocol, LocalRepositoryProtocol {
    var remote: RemoteRepositoryProtocol { get }
    var local: LocalRepositoryProtocol { get }
}

//
typealias SuccessResponse = ([Movie], String)
protocol RemoteRepositoryProtocol {
    func getMovies(from url: String, _ completionHandler: @escaping (Result<SuccessResponse, NetworkError>) -> Void)
    func getData(from url: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
    func getMovieCompany(companyID: String , completionHandler: @escaping (Result<MovieProd, NetworkError>) -> Void)
}

// will be in charge to save data on disk
protocol LocalRepositoryProtocol {
    func getMovies() -> [Movie]
    func saveMovies(_ movies: [Movie])
    func removeAllMovies()
}
