//
//  Model.swift
//  MovieApp
//
//  Created by Barbara Kos on 04.05.2022..
//

import Foundation

struct Movie : Codable, Hashable {
    
    let genre_ids : [Int]
    let id : Int
    let title : String
    let overview : String
    let poster_path : String
    let release_date : String
    let vote_average : Float
    
}

struct MovieDetail : Codable {
    
    
    let genres : [Genre]
    let id : Int
    let overview : String
    let poster_path : String
    let release_date : String
    let runtime : Int
    let title : String
    let vote_average : Float
    
}

struct MoviesData : Codable {
    let movies : [Movie]
    
    private enum CodingKeys : String, CodingKey {
        case movies = "results"
    }
}

struct Genre : Codable {
    let id : Int
    let name : String
}

struct GenresData : Codable {
    let genres : [Genre]
}
