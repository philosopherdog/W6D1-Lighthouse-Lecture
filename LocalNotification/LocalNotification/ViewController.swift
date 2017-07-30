//
//  ViewController.swift
//  LocalNotification
//
//  Created by steve on 2016-07-30.
//  Copyright © 2016 steve. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
        scheduleNotification()
        postNotification()
    }
    
    fileprivate func scheduleNotification() {
        let notification = UILocalNotification()
        let calendar = Calendar.current
        var seconds = DateComponents()
        seconds.second = 10
        let date = (calendar as NSCalendar).date(byAdding: seconds, to: Date(), options:NSCalendar.Options.matchStrictly)
        notification.fireDate = date
        
        notification.alertBody = "Example alert Body!"
        
        notification.alertTitle = "Some Title"
        notification.alertAction = "Go Bananas!"
        notification.applicationIconBadgeNumber = 1
        notification.soundName = "sound.caf"
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    fileprivate func postNotification() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ExampleNotification"), object: nil)
    }
}

