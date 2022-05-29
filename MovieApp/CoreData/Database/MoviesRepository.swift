//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by Barbara Kos on 28.05.2022..
//

import Foundation
import UIKit

class MoviesRepository {
    
    let network = MoviesNetworkDataSource()
    let database = MoviesDatabaseDataSource()
    
    init() {
        
    }
    
    func fetchAndSaveAllMovies() {
        network.fetchAllMovies { [weak self] in
                DispatchQueue.main.async {
                    for movie in self!.network.allMovies {
                        self?.database.addMovie(movie: movie)
                    }
                }
        }
    }
    
    func fetchAndSaveAllGenres() {
        network.fetchAllGenres { [weak self] in
            DispatchQueue.main.async {
                for genre in self!.network.genres {
                    self?.database.addGenre(genre: genre)
                }
            }
        }
    }
    
    func numberOfAllMoviesInSection(section: Int) -> Int {
        network.allMovies = Array(Set(network.allMovies))
        
        return network.allMovies.count
    }
    
    func cellForAllMoviesItemAt(indexPath : IndexPath) -> MovieModel {
        return network.allMovies[indexPath.row]
    }
    
    func numberOfGenreItemsInSection(section: Int) -> Int {
        return network.genres.count
    }
    
    func cellForGenreItemAt(indexPath : IndexPath) -> GenreModel {
        return network.genres[indexPath.row]
    }
    
}
