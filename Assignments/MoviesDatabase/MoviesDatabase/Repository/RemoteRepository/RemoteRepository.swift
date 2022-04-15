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
                    print("---Error: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                
                print("response: \(response)")
             //   let afterKey = response.totalPages  //.data.after
                let movies = response.movie.map { $0 }
                let photos = response.movie.map { $0 }//.data.children.map { $0.data }
                
                completionHandler(.success((movies, "afterKey")))
            }
            .store(in: &subscribers)
    }
    
    static func downloadData(from url: String, completionHandler: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completionHandler(data)
            
            
        }.resume()
    }
        
    
    static func getMovies(from url: String, completionHandler: @escaping ([Movie]) -> Void) {
        
        guard let url = URL(string: url) else {
            completionHandler([])
            return
        }
        
        //URLSession.shared.dataTask(with: url) { data, _, _ in
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
        
            if let data = data {
                
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
//                        let response = MovieResponseAux(from: jsonObject)
//                        completionHandler(response.results)
                    }
                    
                    
                } catch  { }
                
            }
        }.resume()
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
