//
//  User+CoreDataProperties.swift
//  MeetUp
//
//  Created by ChongSun on 21/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var age: String?
    @NSManaged var city: String?
    @NSManaged var email: String?
    @NSManaged var name: String?
    @NSManaged var password: String?
    @NSManaged var protrait: NSData?

}
