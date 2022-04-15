//
//  ViewModels.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation
import Combine

protocol ViewModelProtocol {
    var totalRowsMovies: Int { get }
    var totalRowsFavs: Int { get }
    var publisherMovies: Published<[Movie]>.Publisher { get }
    var publisherPhotoCache: Published<[Int: Data]>.Publisher { get }
    func getMovies()
    func getTitle(by row: Int) -> String?
    func getOverview(by row: Int) -> String?
//    func get(by row: Int) -> String?
    func loadMoreMovies()
    func forceUpdate()
    func getImageData(by row: Int) -> Data?
}

class ViewModel: ViewModelProtocol {
//    func getImageData(by row: Int) -> Data? {
//        <#code#>
//    }
    
    func getOverview(by row: Int) -> String? {
        guard row < movies.count else { return nil }
        let movie = movies[row]
        return movie.overview
    }
    
    
    var totalRowsMovies: Int { movies.count }
    var totalRowsFavs: Int  { favs.count }
    var publisherMovies: Published<[Movie]>.Publisher  { $movies }
    var publisherPhotoCache: Published<[Int : Data]>.Publisher { $photoCache }
    
    private let repository: RepositoryProtocol
    private var subscribers = Set<AnyCancellable>()
    @Published private(set) var movies = [Movie]()
    @Published private(set) var favs = [MovieItem]()
    private var afterKey = ""
    private var isLoading = false
    @Published private var photoCache: [Int: Data] = [:]
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies() {
        // 1. review the current data on the disk
        let movies = repository.getMovies()
        if movies.isEmpty {
            getMovies(from: createURL(), forceUpdate: true)
        } else {
            self.movies = movies
        }
    }
    
    func loadMoreMovies() {
        let newURL = createURL(afterKey)
        getMovies(from: newURL)
    }
    
    func forceUpdate() {
        movies = []
        photoCache = [:]
        repository.removeAllMovies()
        getMovies()
    }
    
      
    private func createURL(_ afterKey: String? = nil) -> String {
        guard let afterKey = afterKey else {
            return NetworkURLs.urlBase
        }
        return "\(NetworkURLs.urlBase)?after=\(afterKey)"
    }

    
    private func getMovies(from url: String, forceUpdate: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        print("In GetMovies Method...")
        // 2. get data from API
        repository.getMovies(from: url) { [weak self] result in
          
            print("result viewModel: \(result)")
            
            switch result {
            case .success(let tuple):
                self?.afterKey = tuple.1
                print("Tuple: \(tuple)")
                if forceUpdate {
                    self?.movies = tuple.0
                    self?.repository.removeAllMovies()
                } else {
                    self?.movies.append(contentsOf: tuple.0)
                    print("Tuple.0 : \(tuple.0)")
                }
                // 3. save on disk new stories
                self?.repository.saveMovies(tuple.0)
                self?.isLoading = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
   
    
    func getImageData(by row: Int) -> Data? {
//        return photoCache[row]
//        getMovies(url: "")
//        let url = NetworkURLs.urlBase
//        let movies:[Movie] = self.getMovies(from: url)
       
//        getMovies()
        var data = Data()
        let urlBase = "https://image.tmdb.org/t/p/w500"
        guard let photoData = movies[row].poster_path else {
            return Data()
        }
        
        let finalUrl = urlBase + photoData
        print(finalUrl)
        
        guard let url = URL(string: (finalUrl))
        else { return Data()}
        
        do {
             data = try Data(contentsOf: url)
           
        } catch (let error) {
            print(error.localizedDescription)
            
        }
        
        return data
        
    }
    
    func getTitle(by row: Int) -> String? {
        guard row < movies.count else { return nil }
        let movie = movies[row]
        return movie.title
    }
  
    
    

}
