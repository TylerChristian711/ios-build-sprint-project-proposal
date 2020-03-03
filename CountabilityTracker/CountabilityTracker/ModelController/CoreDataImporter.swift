//
//  CoreDataImporter.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation
import CoreData

class CoreDataImporter {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func sync(entries: [EntryRepresentation], completion: @escaping (Error?) -> Void = { _ in }) {
        print("Sync has started")
        let identifiersToFetch = entries.compactMap { $0.identifier }
        let repsById = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch,entries))
        var entriesToCreate = repsById
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
        let context = CoreDataStack.shared.container.newBackgroundContext()
        
        context.performAndWait {
            do {
                let existingEntries = try context.fetch(fetchRequest)
                for entry in existingEntries {
                    guard let identifire = entry.identifier,
                        let representaion = repsById[identifire] else { continue }
                    
                    update(entry: entry, with: representaion)
                    
                    entriesToCreate.removeValue(forKey: identifire)
                }
                
                for representation in entriesToCreate.values {
                   let _ = Entry(entryRepresentation: representation, context: context)
                }
                try context.save()
            } catch {
                return
            }
        }
    }
    
    
    private func update(entry: Entry, with entryRep: EntryRepresentation) {
        entry.title = entryRep.title
        entry.bodytext = entryRep.bodyText
        entry.date = entryRep.date
        entry.identifier = entryRep.identifier
    }
    
    private func fetchSingleEntryFromPersistentStore(with identifier: String?, in context: NSManagedObjectContext) -> Entry? {
        guard let identifier = identifier else { return nil }
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifier)
        
        var results: Entry? = nil
        do {
             results = try context.fetch(fetchRequest).first
        } catch {
            NSLog("Error fetching single entry: \(error)")
        }
        return results
    }
    
}
