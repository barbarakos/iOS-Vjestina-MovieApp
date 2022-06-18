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
        database.createGroups()
    }
    
    func fetchAndSaveAllMovies() {
        self.network.fetchAllMovies {
            DispatchQueue.main.async() {
                print("Popular")
                print(self.network.popularMovies.count)
                for movie in self.network.popularMovies {
                    self.database.addMovieAndGroup(movie: movie, groupName: "Popular")
                }
                print("Trending")
                print(self.network.trendingMovies.count)
                for movie in self.network.trendingMovies {
                    self.database.addMovieAndGroup(movie: movie, groupName: "Trending")
                }
                print("Top Rated")
                print(self.network.topRatedMovies.count)
                for movie in self.network.topRatedMovies {
                    self.database.addMovieAndGroup(movie: movie, groupName: "Top Rated")
                }
                print("Recommended")
                print(self.network.recommendedMovies.count)
                for movie in self.network.recommendedMovies {
                    self.database.addMovieAndGroup(movie: movie, groupName: "Recommended")
                }
                self.database.getAllMovies(fetchRequest: Movie.fetchRequest())
            }
        }
    }
    
    func fetchAndSaveAllGenres() {
        self.network.fetchAllGenres {
            DispatchQueue.main.async {
                for genre in self.network.genres {
                    self.database.addGenre(genre: genre)
                }
                self.database.setGenresForMovies()
            }
        }
    }
        
    
    func update() {
        database.getAllMovies(fetchRequest: Movie.fetchRequest())
        database.getAllGroups()
        database.getAllGenres()
    }
    
    func changeFavoriteValue(movie: Movie) {
        database.changeFavoriteValue(movie: movie)
    }
    
}
