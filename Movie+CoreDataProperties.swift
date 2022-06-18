//
//  Movie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Barbara Kos on 29.05.2022..
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var genre_ids: [Int]?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: Data?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Float
    @NSManaged public var genres: [MovieGenre]?
    @NSManaged public var groups: [MovieGroup]?

}

// MARK: Generated accessors for genres
extension Movie {

    @objc(insertObject:inGenresAtIndex:)
    @NSManaged public func insertIntoGenres(_ value: MovieGenre, at idx: Int)

    @objc(removeObjectFromGenresAtIndex:)
    @NSManaged public func removeFromGenres(at idx: Int)

    @objc(insertGenres:atIndexes:)
    @NSManaged public func insertIntoGenres(_ values: [MovieGenre], at indexes: NSIndexSet)

    @objc(removeGenresAtIndexes:)
    @NSManaged public func removeFromGenres(at indexes: NSIndexSet)

    @objc(replaceObjectInGenresAtIndex:withObject:)
    @NSManaged public func replaceGenres(at idx: Int, with value: MovieGenre)

    @objc(replaceGenresAtIndexes:withGenres:)
    @NSManaged public func replaceGenres(at indexes: NSIndexSet, with values: [MovieGenre])

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: MovieGenre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: MovieGenre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSOrderedSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSOrderedSet)

}

// MARK: Generated accessors for groups
extension Movie {

    @objc(insertObject:inGroupsAtIndex:)
    @NSManaged public func insertIntoGroups(_ value: MovieGroup, at idx: Int)

    @objc(removeObjectFromGroupsAtIndex:)
    @NSManaged public func removeFromGroups(at idx: Int)

    @objc(insertGroups:atIndexes:)
    @NSManaged public func insertIntoGroups(_ values: [MovieGroup], at indexes: NSIndexSet)

    @objc(removeGroupsAtIndexes:)
    @NSManaged public func removeFromGroups(at indexes: NSIndexSet)

    @objc(replaceObjectInGroupsAtIndex:withObject:)
    @NSManaged public func replaceGroups(at idx: Int, with value: MovieGroup)

    @objc(replaceGroupsAtIndexes:withGroups:)
    @NSManaged public func replaceGroups(at indexes: NSIndexSet, with values: [MovieGroup])

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: MovieGroup)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: MovieGroup)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSOrderedSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSOrderedSet)

}

extension Movie : Identifiable {

}
