//
//  JotController.swift
//  Jot
//
//  Created by Pierre on 5/3/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import Foundation
import CoreData

class JotController {
    
    fileprivate let kJot = "Jot"
    
    static let sharedController = JotController()
    
    
    var jot: [Jot] {
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            return try moc.fetch(NSFetchRequest(entityName: kJot))
        } catch {
            return []
        }
    }
    
    
    func saveJot(_ jot: Jot) {
        saveToPersistantStorage()
    }
    
    func deleteJot(_ jot: Jot) {
        jot.managedObjectContext?.delete(jot)
        saveToPersistantStorage()
    }

    
    //MARK: Save to CoreData
    func saveToPersistantStorage() {
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            try moc.save()
        } catch {
            print("Error saving to persistant storage")
        }
    }
}
