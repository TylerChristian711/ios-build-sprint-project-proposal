//
//  Entry+Convenience.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/2/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    convenience init(title: String,
                     bodyText: String,
                     date: Date = Date(),
                     identifier: String = UUID().uuidString,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.title = title
        self.bodytext = bodyText
        self.date = date
        self.identifier = identifier
        
    }
    
    convenience init?(entryRepresentation: EntryRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let title = entryRepresentation.title,
            let bodytext = entryRepresentation.bodyText,
            let date = entryRepresentation.date,
            let identifire = entryRepresentation.identifier else { return nil }
        
        self.init(title: title, bodyText:bodytext, date: date, identifier: identifire, context: context)
    }
    
    
}
