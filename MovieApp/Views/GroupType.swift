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
    case freeToWatch
    case trending
    case topRated
    case upcoming
    
    static let allValues = [popular, freeToWatch, trending, topRated, upcoming]
    
    public var title: String {
        switch self {
        case .popular:
            return "What's popular"
        case .freeToWatch:
            return "Free to Watch"
        case .trending:
            return "Trending"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming movies"
        }
    }
    
    public var toMovieGroup : MovieGroup {
        switch self {
        case .popular:
            return .popular
        case .freeToWatch:
            return .freeToWatch
        case .trending:
            return .trending
        case .topRated:
            return .topRated
        case .upcoming:
            return .upcoming
        }
    }
    
    public var filters: [FilterType] {
        switch self {
        case .popular:
            return [.streaming, .onTv, .inTheaters]
        case .freeToWatch:
            return [.drama, .thriller, .horror, .action]
        case .trending:
            return [.day, .week, .month]
        case .topRated:
            return [.day, .month, .allTime]
        case .upcoming:
            return [.drama, .comedy, .sport, .sciFi]
        }
    }
}
