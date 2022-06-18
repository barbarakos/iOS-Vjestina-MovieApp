//
//  MoviesNetworkDataSource.swift
//  MovieApp
//
//  Created by Barbara Kos on 28.05.2022..
//

import UIKit

class MoviesNetworkDataSource: NetworkService { // dohvat filmova s mreze
    
    var allMovies = [MovieModel]()
    var genres = [GenreModel]()
    
    var popularMovies = [MovieModel]()
    var trendingMovies = [MovieModel]()
    var topRatedMovies = [MovieModel]()
    var recommendedMovies = [MovieModel]()

    func fetchAllMovies(completionHandler: @escaping () -> ()) {
        allMovies.removeAll()
        executeMovieUrlRequest(for: "/movie/popular?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"){ [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allMovies.append(contentsOf: listOf.movies)
                self?.popularMovies.append(contentsOf: listOf.movies)
                completionHandler()
                
            case .failure(let error):
                print("Error processing data: \(error)")
                
            }
        }
        
        executeMovieUrlRequest(for: "/trending/movie/day?api_key=6485b76b569ed96963a3f0e786cd369c&page=1"){ [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allMovies.append(contentsOf: listOf.movies)
                self?.trendingMovies.append(contentsOf: listOf.movies)
                completionHandler()
                
            case .failure(let error):
                print("Error processing data: \(error)")
                
            }
        }
        
        executeMovieUrlRequest(for: "/movie/popular?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c") { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allMovies.append(contentsOf: listOf.movies)
                self?.trendingMovies.append(contentsOf: listOf.movies)
                
            case .failure(let error):
                print("Error processing data: \(error)")
                
            }
        }
        
        executeMovieUrlRequest(for: "/movie/top_rated?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c&page=1") { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allMovies.append(contentsOf: listOf.movies)
                self?.topRatedMovies.append(contentsOf: listOf.movies)
                completionHandler()
                
            case .failure(let error):
                print("Error processing data: \(error)")
                
            }
        }
        
        executeMovieUrlRequest(for: "/movie//103/recommendations?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"){ [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.allMovies.append(contentsOf: listOf.movies)
                self?.recommendedMovies.append(contentsOf: listOf.movies)
                completionHandler()
                
            case .failure(let error):
                print("Error processing data: \(error)")
                
            }
        }

    }
    
    func fetchAllGenres(completionHandler: @escaping () -> ()) {
        genres.removeAll()
        executeGenresUrlRequest { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.genres.append(contentsOf: listOf.genres)
                completionHandler()
                    
            case .failure(let error):
                print("Error processing data: \(error)")
                    
            }
            
        }
    }
    
}
