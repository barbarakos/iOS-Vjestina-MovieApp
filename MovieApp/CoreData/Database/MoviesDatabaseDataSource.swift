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
    var genres = [MovieGenre]()
    var groups = [MovieGroup]()
    
    func createGroups() {
        getAllGroups()
        if (groups.isEmpty) {
            let popular = MovieGroup(context: context)
            popular.name = "Popular"
            let trending = MovieGroup(context: context)
            trending.name = "Trending"
            let toprated = MovieGroup(context: context)
            toprated.name = "Top Rated"
            let recommended = MovieGroup(context: context)
            recommended.name = "Recommended"
        
            do {
                try context.save()
            } catch {
                //handle
            }
        }
        
        getAllGroups()
    }
    
    func getAllMovies(fetchRequest: NSFetchRequest<Movie>) {
        movies.removeAll()
        do {
            movies = try context.fetch(fetchRequest)
        } catch {
            // handle error
        }
    }
    
    func getAllGenres() {
        genres.removeAll()
        do {
            genres = try context.fetch(MovieGenre.fetchRequest())
        } catch {
            // handle error
        }
        groups = groups.sorted { $0.name! < $1.name! }
    }
    
    func getAllGroups() {
        groups.removeAll()
        do {
            groups = try context.fetch(MovieGroup.fetchRequest())
        } catch {
            // handle error
        }
    }
    
    func addMovieAndGroup(movie: MovieModel, groupName: String) {
        getAllGroups()
        getAllMovies(fetchRequest: Movie.fetchRequest())
        var theGroup: MovieGroup!
        for group in groups {
            if(groupName == group.name) {
                theGroup = group
            }
        }
        var exists : Bool = false
        for movie2 in movies {
            if (movie2.id == movie.id) {
                exists = true
            }
        }
        if(!exists) {
            let newMovie = Movie(context: context)
            newMovie.genre_ids = movie.genre_ids
            newMovie.id = Int64(movie.id)
            newMovie.overview = movie.overview
            let urlString = "https://image.tmdb.org/t/p/original" + movie.poster_path
            guard let url = URL(string: urlString) else {return}
            
            newMovie.poster_path = try! Data(contentsOf: url)
            newMovie.release_date = movie.release_date
            newMovie.title = movie.title
            newMovie.vote_average = movie.vote_average
            newMovie.favorite = false
        
            theGroup.addToMovies(newMovie)
            do {
                try context.save()
            } catch {
                //handle
            }
        }
        
        getAllMovies(fetchRequest: Movie.fetchRequest())
    }
    
    func addGenre(genre: GenreModel) {
        getAllGenres()
        var exists : Bool = false
        for genre2 in genres {
            if (genre2.id == genre.id) {
                exists = true
            }
        }
        if(!exists) {
            let newGenre = MovieGenre(context: context)
            newGenre.name = genre.name
            newGenre.id = Int64(genre.id)
        
            do {
                try context.save()
            } catch {
                //handle
            }
        }
        getAllGenres()
    }
    
    func setGenresForMovies() {
        getAllGenres()
        getAllMovies(fetchRequest: Movie.fetchRequest())
        for movie in movies {
            for genreid in movie.genre_ids! {
                for genre in genres {
                    if (!(movie.genres?.contains(genre))!) {
                        if (genre.id == genreid) {
                            movie.addToGenres(genre)
                        }
                    }
                }
            }
        }
        do {
            try context.save()
        } catch {
            //handle
        }
        getAllMovies(fetchRequest: Movie.fetchRequest())
    }
    
    func changeFavoriteValue(movie: Movie) {
        if (movie.favorite) {
            movie.favorite = false
        } else {
            movie.favorite = true
        }
        do {
            try context.save()
        } catch {
            //handle
        }
        getAllMovies(fetchRequest: Movie.fetchRequest())
    }
    
    
}
