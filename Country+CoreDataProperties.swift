//
//  Country+CoreDataProperties.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var countryName: String?

}

extension Country : Identifiable {

}
