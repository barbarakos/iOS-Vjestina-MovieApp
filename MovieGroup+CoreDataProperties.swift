//
//  MovieGroup+CoreDataProperties.swift
//  MovieApp
//
//  Created by Barbara Kos on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGroup> {
        return NSFetchRequest<MovieGroup>(entityName: "MovieGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var movies: [Movie]?

}

// MARK: Generated accessors for movies
extension MovieGroup {

    @objc(insertObject:inMoviesAtIndex:)
    @NSManaged public func insertIntoMovies(_ value: Movie, at idx: Int)

    @objc(removeObjectFromMoviesAtIndex:)
    @NSManaged public func removeFromMovies(at idx: Int)

    @objc(insertMovies:atIndexes:)
    @NSManaged public func insertIntoMovies(_ values: [Movie], at indexes: NSIndexSet)

    @objc(removeMoviesAtIndexes:)
    @NSManaged public func removeFromMovies(at indexes: NSIndexSet)

    @objc(replaceObjectInMoviesAtIndex:withObject:)
    @NSManaged public func replaceMovies(at idx: Int, with value: Movie)

    @objc(replaceMoviesAtIndexes:withMovies:)
    @NSManaged public func replaceMovies(at indexes: NSIndexSet, with values: [Movie])

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSOrderedSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSOrderedSet)

}

extension MovieGroup : Identifiable {

}
