//
//  SettingsViewController.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//
//
//import UIKit
//import UserNotifications
//
//class SettingsViewController: UIViewController {
//    
//    @IBOutlet weak var timeReminder: UIDatePicker!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
////    func notification() {
////        let content = UNMutableNotificationContent()
////        content.title = "CountAbilityTracker"
////        content.body = "Time to reflect on the day!"
////        content.sound = .default
////
////        let gregorian = Calendar(identifier: .gregorian)
////        let now = Date()
////        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
////
////        components.hour = 7
////        components.minute = 30
////        components.second = 0
////
////        let date = gregorian.date(from: components)!
////
////        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: date)
////        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
////
////        let identifier = "UYLLocalNotification"
////        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
////
////
////        UNUserNotificationCenter.current().add(request) { (error) in
////            if let error = error {
////                print("Something is wrong most liekly on line 40 and 39: \(error.localizedDescription)")
////            }
////        }
//    }
//    
//    
//
//}
