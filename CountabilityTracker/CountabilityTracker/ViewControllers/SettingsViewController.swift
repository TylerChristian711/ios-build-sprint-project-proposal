//
//  SettingsViewController.swift
//  CountabilityTracker
//
//  Created by Lambda_School_Loaner_218 on 3/3/20.
//  Copyright © 2020 Lambda_School_Loaner_218. All rights reserved.
//
//
import UIKit
import UserNotifications

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        dateComponents.hour = 1
        dateComponents.minute = 15
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    
    
}




