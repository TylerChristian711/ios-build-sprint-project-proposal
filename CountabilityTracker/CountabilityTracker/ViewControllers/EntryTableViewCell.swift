//
//  EntryTableViewCell.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/4/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var entry:Entry? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let entry = entry else { return }
        titleLabel.text = entry.title
        dateLabel.text = DateTimeFormatter.formatDateStamp(for: entry)
    }
    
}
