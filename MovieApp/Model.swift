//
//  Model.swift
//  MovieApp
//
//  Created by Barbara Kos on 04.05.2022..
//

import Foundation

struct MovieModel : Codable, Hashable {
    
    let genre_ids : [Int]
    let id : Int
    let title : String
    let overview : String
    let poster_path : String
    let release_date : String
    let vote_average : Float
    
}

struct MovieDetailModel : Codable {
    
    
    let genres : [GenreModel]
    let id : Int
    let overview : String
    let poster_path : String
    let release_date : String
    let runtime : Int
    let title : String
    let vote_average : Float
    
}

struct MoviesData : Codable {
    let movies : [MovieModel]
    
    private enum CodingKeys : String, CodingKey {
        case movies = "results"
    }
}

struct GenreModel : Codable {
    let id : Int
    let name : String
}

struct GenresData : Codable {
    let genres : [GenreModel]
}
