//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Barbara Kos on 05.05.2022..
//

import UIKit

class MovieViewModel {

    private var networkService = NetworkService()
    
    private var genres = [Genre]()
    
    private var allMovies = [Movie]()
    private var popularMovies = [Movie]()
    private var trendingMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var recommendedMovies = [Movie]()
    
    var detailedMovie : MovieDetail!
    
    func fetchMoviesData(for groupType: GroupType, completionHandler: @escaping () -> ()) {
        var endURL = ""
        var endURL2 = ""
        switch groupType {
        case .popular:
            endURL = "/movie/popular?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"
        case .trending:
            endURL = "/trending/movie/day?api_key=6485b76b569ed96963a3f0e786cd369c&page=1"
            endURL2 = "/trending/movie/week?api_key=6485b76b569ed96963a3f0e786cd369c&page=1"
        case .topRated:
            endURL = "/movie/top_rated?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c&page=1"
        case .recommended:
            endURL = "/movie//103/recommendations?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"
        }
        
        networkService.executeMovieUrlRequest(for: endURL){ [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                switch groupType {
                case .popular:
                    self?.popularMovies = listOf.movies
                case .trending:
                    self?.trendingMovies = listOf.movies
                    self?.networkService.executeMovieUrlRequest(for: endURL2){ [weak self] (result) in
                        switch result {
                        case .success(let value):
                            self?.trendingMovies.append(contentsOf: value.movies)
                            completionHandler()
                        case .failure(let error):
                            print("Error processing data: \(error)")
                        }
                    }
                case .topRated:
                    self?.topRatedMovies = listOf.movies
                case .recommended:
                    self?.recommendedMovies = listOf.movies
                }
                completionHandler()
                    
            case .failure(let error):
                print("Error processing data: \(error)")
                    
            }
            
        }
    }
    
    func numberOfItemsInSection(for groupType: GroupType, section: Int) -> Int {
        switch groupType {
        case .popular:
            return popularMovies.count
        case .trending:
            return trendingMovies.count
        case .topRated:
            return topRatedMovies.count
        case .recommended:
            return recommendedMovies.count
        }
    }
    
    func cellForItemAt(for groupType: GroupType, indexPath : IndexPath) -> Movie {
        switch groupType {
        case .popular:
            return popularMovies[indexPath.row]
        case .trending:
            return trendingMovies[indexPath.row]
        case .topRated:
            return topRatedMovies[indexPath.row]
        case .recommended:
            return recommendedMovies[indexPath.row]
        }
    }
    
    func fetchGenresData(for groupType: GroupType, completionHandler: @escaping () -> ()) {
        genres.removeAll()
        for filterName in groupType.filters {
            genres.append(Genre(id: 1, name: filterName))
        }
        networkService.executeGenresUrlRequest { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.genres.append(contentsOf: listOf.genres)
                completionHandler()
                    
            case .failure(let error):
                print("Error processing data: \(error)")
                    
            }
            
        }
    }
    
    func numberOfGenreItemsInSection(section: Int) -> Int {
        return genres.count
    }
    
    func cellForGenreItemAt(indexPath : IndexPath) -> Genre {
        return genres[indexPath.row]
    }
    
    func fetchAllMovies(completionHandler: @escaping () -> ()) {
        let endURLS:[String] = ["/movie/popular?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c",
                                "/trending/movie/day?api_key=6485b76b569ed96963a3f0e786cd369c&page=1",
                                "/trending/movie/week?api_key=6485b76b569ed96963a3f0e786cd369c&page=1",
                                "/movie/top_rated?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c&page=1",
                                "/movie//103/recommendations?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"]
        for endURL in endURLS {
            networkService.executeMovieUrlRequest(for: endURL){ [weak self] (result) in
            
                switch result {
                case .success(let listOf):
                    self?.allMovies.append(contentsOf: listOf.movies)
                    completionHandler()
                    
                case .failure(let error):
                    print("Error processing data: \(error)")
                    
                }
            }
        }
    }
    
    func numberOfAllMoviesInSection(section: Int) -> Int {
        allMovies = Array(Set(allMovies))
        
        return allMovies.count
    }
    
    func cellForAllMoviesItemAt(indexPath : IndexPath) -> Movie {
        return allMovies[indexPath.row]
    }
    
    func fetchDetailedMovie(for movie : Movie, completionHandler: @escaping () -> ()) {
        networkService.getDetailedMovie(urlstring: "/movie/\(movie.id)?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"){ [weak self] (result) in
        
            switch result {
            case .success(let value):
                self?.detailedMovie = value
                completionHandler()
                
            case .failure(let error):
                print("Error processing data: \(error)")
                
            }
        }
    }
    
    
}
