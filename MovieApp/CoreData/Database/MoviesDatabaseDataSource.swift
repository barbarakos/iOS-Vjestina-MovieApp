//
//  MoviesDatabaseDataSource.swift
//  MovieApp
//
//  Created by Barbara Kos on 28.05.2022..
//

import Foundation
import UIKit
import CoreData

class MoviesDatabaseDataSource { //dohvat i spremanje filmova u bazu podataka
    
    let context = CoreDataStack.shared.persistentContainer.viewContext
    
    var movies = [Movie]()
    
    func getAllMovies(fetchRequest: NSFetchRequest<Movie>) {
        do {
//            var fetchReqest: NSFetchRequest<Movie>
//            fetchRequest = Movie.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "name LIKE %@", "Robert")
            movies = try context.fetch(fetchRequest)
        } catch {
            // handle error
        }
    }
    
    func addMovie(movie: MovieModel) {
        let newMovie = Movie(context: context)
        newMovie.genre_ids = movie.genre_ids
        newMovie.id = movie.id
        newMovie.overview = movie.overview
        newMovie.poster_path = movie.poster_path
        newMovie.release_date = movie.release_date
        newMovie.title = movie.title
        newMovie.vote_average = movie.vote_average
        newMovie.favorite = false
        
        do {
            try context.save()
        } catch {
            //handle
        }
    }
    
    
    
    
}
