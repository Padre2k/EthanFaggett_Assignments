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
    var totalRowsCompany: Int { get }
    var publisherMovies: Published<[Movie]>.Publisher { get }
    var publisherPhotoCache: Published<[Int: Data]>.Publisher { get }
    func getMovies()
    func getTitle(by row: Int) -> String?
    func getOverview(by row: Int) -> String?
//    func get(by row: Int) -> String?
    func loadMoreMovies()
    func forceUpdate()
    func getImageData(by row: Int) -> Data?
    func getFavsFlag() -> [MovieItem]
    func searchItem(word: String) -> [Movie]
    var filteredData: [Movie]{ get set }
    func getMoviesReturn(completionHandler: ()->()) -> [Movie]
    func getMovieCompany(companyID: String)
    func getMovieID(by row: Int) -> Int
}

class ViewModel: ViewModelProtocol {
    var totalRowsCompany: Int { totalComps.count }
    
//    var filteredData: [Movie]
    
    var filteredData: [Movie] = [Movie]()
//    var companies = MovieProd()
    
    func searchItem(word: String) -> [Movie] {
        
        return [Movie]()
    }

    
    func getOverview(by row: Int) -> String? {
        guard row < movies.count else { return nil }
        let movie = movies[row]
        return movie.overview
    }
    
    func getFavsFlag() -> [MovieItem] {
        //        guard row < movies.count else { return nil }
        //        let movie = movies[row]
        var array = [MovieItem]()
        for item in movies {
            let id = item.id
            let isFav = false
            let title = item.title
            
            let current = MovieItem(id: id, title: title, isFavorite: isFav)
            array.append(current)
        }
        print("the array.....\(array)")
        return array
    }
    
    var totalRowsProd: Int { movies.count }
    var totalRowsMovies: Int { movies.count }
    var totalRowsFavs: Int  { moviesFav.count }
    var publisherMovies: Published<[Movie]>.Publisher  { $movies }
    var publisherPhotoCache: Published<[Int : Data]>.Publisher { $photoCache }
    
    
    private let repository: RepositoryProtocol
    private var subscribers = Set<AnyCancellable>()
    @Published private(set) var movies = [Movie]()
    @Published private(set) var moviesFav = [Movie]()
    private var afterKey = ""
    private var isLoading = false
    private var totalComps = [MovieCompany]()
    @Published private var photoCache: [Int: Data] = [:]
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies() {
        // 1. review the current data on the disk
      
        
//        let movies = repository.getMovies()
        let movies = [Movie]()
        
        if movies.isEmpty {
            getMovies(from: createURL(), forceUpdate: true)
        } else {
            self.movies = movies
            }
    }
   
    func getMoviesReturn(completionHandler: ()->()) -> [Movie]{
        let movies = [Movie]()
        if movies.isEmpty {
            getMovies(from: createURL(), forceUpdate: true)
        } else {
            self.movies = movies
            }
        return movies
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
        guard let afterKey = afterKey, !afterKey.isEmpty else {
            return NetworkURLs.urlMoviesPopular
        }
//        return "\(NetworkURLs.urlBase)&after=\(afterKey)"
        return NetworkURLs.urlMoviesPopular
    }

    func getMovieCompany(companyID: String) {
        repository.getMovieCompany(companyID: companyID) { [weak self] result in
            print("company results: \(result)")
            
            switch result {
            case .success(let comp):
//                self?.companies = posts
                print("comp: \(comp.productionCompanies)")
                let item = comp.productionCompanies
                
              //  totalComps.append(result.map({ $0
                    let companies = item.map { $0 }
                for parts in companies {
                    
                    let id = parts.id
                    
                    if let title = parts.name as? String,  //as? String) ?? ""
                    let imagePath = parts.logoPath as? String
                        {
                        
                        let newItem = MovieCompany(id: id, logoPath: imagePath, name: title, originCountry: "US")
                        self!.totalComps.append(newItem)
                        print("individual companies: \(self!.totalComps)")
                    }
                
                    
                    
                }
                    
                    //  let movies = response.movie.map { $0 }
                    
          //      print("companies : \(companies)")
                
//                let company = item.$0.
                
            case .failure(let error):
                let error = error
                print(error.localizedDescription)
            }
            
            
            
        }
    }
    
    private func getMovies(from url: String, forceUpdate: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        print("In GetMovies Method...")
        // 2. get data from API
        repository.getMovies(from: url) { [weak self] result in
          
       //     print("result viewModel: \(result)")
            
            switch result {
            case .success(let tuple):
                self?.afterKey = tuple.1
           //     print("Tuple: \(tuple)")
                if forceUpdate {
                    self?.movies = tuple.0
                    self?.repository.removeAllMovies()
                } else {
                    self?.movies.append(contentsOf: tuple.0)
         //           print("Tuple.0 : \(tuple.0)")
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
       
    //    print("movies: \(movies)")
//        if movies.count == 0 {
//              getMovies()
//        }
     
        var data = Data()
        let urlBase = NetworkURLs.urlPhotoBase
        guard row < movies.count else { return nil }
        let info = movies[row].poster_path
      //  print("movies count: \(movies.count)")
        guard let photoData = info else {
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
  
    func getMovieID(by row: Int) -> Int {
        guard row < movies.count else { return 0 }
        let movie = movies[row]
        return movie.id
    }
    
    

}
