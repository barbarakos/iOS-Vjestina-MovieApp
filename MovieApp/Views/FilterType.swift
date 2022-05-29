//
//  FilterType.swift
//  MovieApp
//
//  Created by Barbara Kos on 10.04.2022..
//

import UIKit
import MovieAppData

public enum FilterType {

    case streaming
    case onTv
    case forRent
    case inTheaters

    // genre
    case thriller
    case horror
    case comedy
    case romanticComedy
    case sport
    case action
    case sciFi
    case war
    case drama

    // time filters
    case day
    case week
    case month
    case allTime
    
    public var title: String {
        switch self {
        case .streaming:
            return "Streaming"
        case .onTv:
            return "On TV"
        case .forRent:
            return "For Rent"
        case .inTheaters:
            return "In theaters"

        // genre
        case .thriller:
            return "Thriller"
        case .horror:
            return "Horror"
        case .comedy:
            return "Comedy"
        case .romanticComedy:
            return "Romantic Comedy"
        case .sport:
            return "Sport"
        case .action:
            return "Action"
        case .sciFi:
            return "SciFi"
        case .war:
            return "War"
        case .drama:
            return "Drama"

        // time filters
        case .day:
            return "Today"
        case .week:
            return "This Week"
        case .month:
            return "This Month"
        case .allTime:
            return "Of All Time"
        }
    }
}
