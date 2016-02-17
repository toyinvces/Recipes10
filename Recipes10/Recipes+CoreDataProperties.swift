//
//  Recipes+CoreDataProperties.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/3/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recipes {

    @NSManaged var name: String?
    @NSManaged var url: String?
    @NSManaged var time: String?
    @NSManaged var extra: String?
    @NSManaged var image: String?

}
