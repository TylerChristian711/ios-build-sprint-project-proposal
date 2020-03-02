//
//  Entry+Encodable.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/2/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation

extension Entry: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(bodytext, forKey: .bodyText)
        try container.encode(date, forKey: .date)
        try container.encode(identifier, forKey: .identifier)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case bodyText
        case date
        case identifier
    }
}
