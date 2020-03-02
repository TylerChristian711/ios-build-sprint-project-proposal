//
//  EntryRepresentation.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/2/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

struct EntryRepresentation: Codable {
    var title: String?
    var bodyText: String?
    var date: Date?
    var identifier: String?
}

func ==(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return rhs.title == lhs.title &&
        rhs.bodytext == lhs.bodyText &&
        rhs.identifier == lhs.identifier
}

func ==(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs == lhs
}

func !=(lhs: EntryRepresentation, rhs: Entry) -> Bool {
    return !(lhs == rhs)
}

func !=(lhs: Entry, rhs: EntryRepresentation) -> Bool {
    return rhs != lhs
}
