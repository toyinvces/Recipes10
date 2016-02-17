//
//  Recipes.swift
//  Recipes10
//
//  Created by Cesar Ramirez on 2/3/16.
//  Copyright © 2016 Cesar Ramirez. All rights reserved.
//

import Foundation
import CoreData


class Recipes: NSManagedObject {

    struct keys {
        static let Name = "name"
        static let Url = "url"
        static let Time = "time"
        static let Extra = "extra"
        static let Image = "image"
    }
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("Recipes", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
      
        name = dictionary[keys.Name] as? String
        url = dictionary[keys.Url] as? String
        time = dictionary[keys.Time] as? String
        extra = dictionary[keys.Extra] as? String
        image = dictionary[keys.Image] as? String
        
        
    }
    

}
