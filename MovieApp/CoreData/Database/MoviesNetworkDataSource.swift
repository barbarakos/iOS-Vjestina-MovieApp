//
//  MoviesNetworkDataSource..swift
//  MovieApp
//
//  Created by Barbara Kos on 28.05.2022..
//

import UIKit

class MoviesNetworkDataSource: NetworkService { // dohvat filmova s mreze
    
    var allMovies = [MovieModel]()
    var genres = [GenreModel]()

    func fetchAllMovies(completionHandler: @escaping () -> ()) {
        allMovies.removeAll()
        let endURLS:[String] = ["/movie/popular?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c",
                                "/trending/movie/day?api_key=6485b76b569ed96963a3f0e786cd369c&page=1",
                                "/trending/movie/week?api_key=6485b76b569ed96963a3f0e786cd369c&page=1",
                                "/movie/top_rated?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c&page=1",
                                "/movie//103/recommendations?language=en-US&page=1&api_key=6485b76b569ed96963a3f0e786cd369c"]
        for endURL in endURLS {
            executeMovieUrlRequest(for: endURL){ [weak self] (result) in
            
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
