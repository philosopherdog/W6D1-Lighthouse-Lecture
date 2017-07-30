//
//  AppDelegate.swift
//  LocalNotification
//
//  Created by steve on 2016-07-30.
//  Copyright © 2016 steve. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setupNotificationSettings()
        self.setupObserver()
        return true
    }
    
    
    fileprivate func setupNotificationSettings() {
        let notificationSettings = UIUserNotificationSettings(types:[ .badge, .alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
    }
    
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.didReceiveNotification) , name: NSNotification.Name(rawValue: "ExampleNotification"), object: nil)
    }
    
    @objc fileprivate func didReceiveNotification() {
        print("Got it!")
    }
    
    fileprivate func clearBadgeNumber() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
  
    //MARK: App Life Cycle
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.clearBadgeNumber()
    }
    
}

