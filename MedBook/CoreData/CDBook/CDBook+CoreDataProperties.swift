//
//  CDBook+CoreDataProperties.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//
//

import Foundation
import CoreData


extension CDBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBook> {
        return NSFetchRequest<CDBook>(entityName: "CDBook")
    }

    @NSManaged public var coverI: Int64
    @NSManaged public var authorName: String
    @NSManaged public var ratingsCount: Int64
    @NSManaged public var ratingsAverage: Double
    @NSManaged public var title: String
    
    //custom functions
    func convertToBook() -> Book {
        return Book(
            title: self.title,
            ratingsAverage: self.ratingsAverage,
            ratingsCount: Int(self.ratingsCount),
            authorName: [self.authorName],
            coverI: Int(self.coverI)
        )
    }

}

extension CDBook : Identifiable {

}
