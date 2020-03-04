//
//  DateTimeFormatter.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

class DateTimeFormatter {
    
    static func formatDateStamp(for entry: Entry) -> String {
        return dateFormatter.string(from: entry.date!)
    }
    
    static let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()
}
