//
//  CoreDataStack.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/2/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CountabilityTracker" as String)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
        
    }()
    
    
    var mainContext: NSManagedObjectContext { return container.viewContext }
}
