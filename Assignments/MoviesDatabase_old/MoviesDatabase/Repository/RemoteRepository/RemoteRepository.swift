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
                
    //            print("response: \(response)")
             //   let afterKey = response.totalPages  //.data.after
                let movies = response.movie.map { $0 }
           //     let imgPaths = response.movie.map { $0 }
//                let photos = response.movie.map {
//                   print( $0.poster_path )
//
//                }//.data.children.map { $0.data }
//                print("photos_: \(photos)")
                completionHandler(.success((movies, "")))
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
        
    
    static func getMovies_old(from url: String, completionHandler: @escaping ([Movie]) -> Void) {
        
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
    
    func getMovieCompany(companyID: String , completionHandler: @escaping (Result<MovieProd, NetworkError>) -> Void) {
        
        //https://api.themoviedb.org/3/movie/634649?api_key=6622998c4ceac172a976a1136b204df4
        //https://api.themoviedb.org/3/company/420?api_key=6622998c4ceac172a976a1136b204df4
        let baseUrl = "https://api.themoviedb.org/3/movie/"
        let apiKey = "?api_key=6622998c4ceac172a976a1136b204df4"
       
        
        let urlString = baseUrl + companyID + apiKey
        guard let url = URL(string: urlString)
        else {
            completionHandler(.failure(.badURL))
            return
        }
        
        print("company url: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(.other(error)))
                return
            }
            
            if let safeData = data {
                do {
                    print("data_Safe: \(safeData)")
                    // automatic
                    let companies = try JSONDecoder().decode(MovieProd.self, from: safeData)
                   
                    
                    //print("companies: \(companies)")
                    completionHandler(.success(companies))
                    
                } catch let error{
                    print("error__1: \(error.localizedDescription)")
//                    completionHandler(.failure(.badDecode))
                }
            }
            
        }.resume()
        
        
    }
    
    
    
}
