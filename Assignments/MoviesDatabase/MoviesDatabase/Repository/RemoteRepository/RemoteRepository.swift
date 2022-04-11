//
//  RemoteRepository.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation
import Combine

class RemoteRepository: RemoteRepositoryProtocol {
    
    private let networkManager: NetworkManager
    private var subscribers = Set<AnyCancellable>()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovies(from url: String, _ completionHandler: @escaping (Result<SuccessResponse, NetworkError>) -> Void) {
        networkManager
            .getModel(MovieResponse.self, from: url)
            .sink { completion in
                switch( completion) {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                
            //    print("response: \(response)")
//                let movie = response["moview"] as! Movie
//                let result = response["results"] as! Movie
                
                for movie in response.movie {

                    print(movie.title)

                }
                
                
             //   let afterKey = response.movie  //.data.after
             //   let movies = response.movie//.children.map { $0.data }   //.data.children.map { $0.data }
             //   completionHandler(.success((movies, afterKey)))
            }
            .store(in: &subscribers)
    }
    
    func getData(from url: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        networkManager.getData(from: url) { data in
            if let data = data {
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(.badURL))
            }
        }
    }
}
