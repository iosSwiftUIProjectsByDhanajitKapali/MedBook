//
//  CDCountry+CoreDataProperties.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//
//

import Foundation
import CoreData


extension CDCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCountry> {
        return NSFetchRequest<CDCountry>(entityName: "CDCountry")
    }

    @NSManaged public var countryName: String?

}

extension CDCountry : Identifiable {

}
