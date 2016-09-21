//
//  Jot+CoreDataClass.swift
//  Jot
//
//  Created by Pierre on 9/21/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import CoreData

public class Jot: NSManagedObject {
    
    convenience init(body: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Jot", in: context)!
        
        self.init(entity: entity, insertInto: context)
        
        self.body = body
    }
    
}
