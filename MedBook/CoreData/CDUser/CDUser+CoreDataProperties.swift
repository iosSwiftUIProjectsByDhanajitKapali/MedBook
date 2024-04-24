//
//  CDUser+CoreDataProperties.swift
//  MedBook
//
//  Created by Dhanajit Kapali on 24/04/24.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    
    //custom functions
    func convertToUser() -> User {
        return User(email: self.email, password: self.password)
    }
}

extension CDUser : Identifiable {

}
