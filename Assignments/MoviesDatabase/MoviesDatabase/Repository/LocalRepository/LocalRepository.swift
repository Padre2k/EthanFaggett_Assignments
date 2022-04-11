//
//  LocalRepository.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation
import CoreData

class LocalRepository: LocalRepositoryProtocol {
    
    let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func getMovies() -> [Movie] {
        let request: NSFetchRequest = CDMovie.fetchRequest()
        let context = coreDataManager.mainContext
        do {
            let movies = try context.fetch(request)
            return movies.map { $0.createMovie() }
        } catch (let error) {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveMovies(_ movies: [Movie]) {
        let context = coreDataManager.mainContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CDMovie", in: context)
        else { return }
        for movie in movies {
            let cdMovie = CDMovie(entity: entityDescription, insertInto: context)
            cdMovie.title = movie.title
//            if let numComments = story.numComments {
//                cdStory.numComments = Int64(numComments)
//            }
            cdMovie.popularity = "\(movie.popularity)"
            cdMovie.id = Int64(movie.id)
            cdMovie.vote_average = "\(movie.vote_average)"
            cdMovie.vote_count = "\(movie.vote_count)"
            cdMovie.release_date = movie.release_date
            cdMovie.poster_path = movie.poster_path
            cdMovie.overview = movie.overview
            
            
//            if let score = story.score {
//                cdStory.score = Int64(score)
//            }
        }
        do {
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func removeAllMovies() {
        let request: NSFetchRequest = CDMovie.fetchRequest()
        let context = coreDataManager.mainContext
        do {
            let movies = try context.fetch(request)
            for movie in movies {
                context.delete(movie)
            }
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
}
