//
//  ViewController.swift
//  UNUserNotificationDemo
//
//  Created by steve on 2017-07-30.
//  Copyright © 2017 steve. All rights reserved.
//

import UIKit

// required for new notifications framework
import UserNotifications


class ViewController: UIViewController {
  
  lazy var notificationCenter = UNUserNotificationCenter.current()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func buttonTapped() {
    // test for authorization. why do it here?
    
    requestAuth { (_) in
      self.createUNNotification()
    }
  }
  
  
  private func requestAuth(completionHandler:@escaping ((Bool)->Void )) {
    
    notificationCenter.requestAuthorization(options: [.alert, .sound]) { (complete: Bool, error: Error?) in
      if let error = error  {
        print(#line, error.localizedDescription, "alert user")
        return
      }
      if complete == false {
        print(#line, "present a warning to the user")
        return
      }
      if complete == true {
        completionHandler(true)
      }
    }
  }
  
  private struct ID {
    static let requestID = "requestID"
    static let attachment1ID = "attachment1ID"
  }
  
  private func createUNNotification() {
    
    let content = UNMutableNotificationContent()
    content.title = "some title"
    content.subtitle = "some subtitle"
    content.body = "some body"
    content.sound = UNNotificationSound(named: "sound.caf")
    let url = Bundle.main.url(forResource: "montreal", withExtension: "jpg")
    
    //     let attachment1 = try? UNNotificationAttachment(identifier: ID.attachment1ID, url: url!)
    
    do {
      let attachment1 = try UNNotificationAttachment(identifier: ID.attachment1ID, url: url!)
      content.attachments = [attachment1]
      
    } catch {
      print(#line, error.localizedDescription)
    }
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
    
    
    let request = UNNotificationRequest(identifier: ID.requestID, content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error: Error?) in
      if let error = error {
        print(#line, error.localizedDescription)
        return
      }
      self.notificationCenter.delegate = self
    }
    
  }
  
  
}


extension ViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
}
