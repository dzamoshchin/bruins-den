//
//  AppDelegate.swift
//  wedwf
//
//  Created by hari sowrirajan on 5/3/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import Firebase
import TwitterKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    var mainViewController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //check whether initial settings need to be set, if not go straight into application
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        var viewController: UIViewController = UIViewController()
//        
//        //viewController = mainStoryboard.instantiateViewController(withIdentifier: "swRevealViewController") as! SWRevealViewController
//        viewController = mainStoryboard.instantiateViewController(withIdentifier: "swRevealViewController")
//        print("User preferences have been set. Instantiating SW Reveal View Controller in AppDelegate")
//        
//        self.window?.makeKeyAndVisible()
//        self.window?.rootViewController = viewController
        //UINavigationBar.appearance().barTintColor = UIColor.red
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
             // For iOS 10 display notification (sent via APNS)
             UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

application.registerForRemoteNotifications()
        
        Twitter.sharedInstance().start(withConsumerKey:"7IXEpM3QcOQdfS9e9GeMPCHYP", consumerSecret:"9bo3cIwn9VkM6UovUt50bttFiP0nkxZs8rW4rFvtSpDEKTeAdO")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

