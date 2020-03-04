//
//  EntryDetialViewController.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit

class EntryDetialViewController: UIViewController {

    var entryController: EntryController?
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField.text?.capitalized,
            let bodyText = bodyTextView.text else { return }
        
        if let entry = entry {
            entryController?.update(with: entry, title: title, bodyText: bodyText)
        } else {
            entryController?.createEntry(with: title, bodyText: bodyText)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func updateViews() {
        guard let entry = entry,
            isViewLoaded else {
                title = "Reflect on Your day"
                return
        }
        
        title = entry.title
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodytext
    }
    
}
