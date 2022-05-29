//
//  GroupType.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import MovieAppData

public enum GroupType {
    case popular
    case trending
    case topRated
    case recommended
    
    static let allValues = [popular, trending, topRated, recommended]
    
    public var title: String {
        switch self {
        case .popular:
            return "What's popular"
        case .trending:
            return "Trending"
        case .topRated:
            return "Top Rated"
        case .recommended:
            return "Recommended"
        }
    }
    
    public var filters: [String] {
        switch self {
        case .popular:
            return ["Streaming", "On Tv", "In Theaters"]
        case .trending:
            return ["Today", "This week", "This month"]
        case .topRated:
            return ["Today", "This month", "All time"]
        case .recommended:
            return []
        }
    }
}
