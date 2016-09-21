//
//  Jot+CoreDataProperties.swift
//  Jot
//
//  Created by Pierre on 9/21/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import CoreData


extension Jot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jot> {
        return NSFetchRequest<Jot>(entityName: "Jot");
    }

    @NSManaged public var body: String?

}
