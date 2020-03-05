//
//  EntryTableViewController.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class EntryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let entryController = EntryController()
    let center = UNUserNotificationCenter.current()
    
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<Entry> = {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        try! frc.performFetch()
        
        return frc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
       
        
        setNotifications()
        refresh(nil)
        
        // MARK: - print out scheduled notifications at scene load
                center.getPendingNotificationRequests { requests in
                    for request in requests {
                        print(request)
                    }
                }
    }
    
    
    
    func setNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            if granted {
                print("User has granted permission")
            } else {
                print("User has NOT granted permission")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Journal Alert"
        content.body = "Don't forget you need to write down what happend today"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData":"Entry"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 24
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    @IBAction func refresh(_ sender: Any?) {
        refreshControl?.beginRefreshing()
        entryController.refreshEntriesFromServer { error in
            if let error = error {
                NSLog("Error refreshing changes from server: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.fetchedResultsController.managedObjectContext.reset()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }

        let entry = fetchedResultsController.object(at: indexPath)
        cell.entry = entry
        
    
        return cell
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddEntrySegue":
            guard let destinationVC = segue.destination as? EntryDetialViewController else { return }
            destinationVC.entryController = entryController
            
        case "ViewEntrySegue":
            guard let destinationVC = segue.destination as? EntryDetialViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.entry = fetchedResultsController.object(at: indexPath)
            destinationVC.entryController = entryController
            
        default:
            break
        }
        
    }
    
    
}
