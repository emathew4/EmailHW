//
//  AppDelegate.swift
//  EmailExample
//
//  Created by Emily Byrne on 9/18/17.
//  Copyright © 2017 Byrne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //TODO: populate our datapool with initial emails
        //NEED: access to datapool object
        let splitVC = self.window?.rootViewController as! UISplitViewController
        let navVC = splitVC.viewControllers.first as! UINavigationController
        let menuTVC = navVC.viewControllers[0] as! MenuTVC
        
        let test = Email(sender: "asu@asu.edu", subject: "Spam", contents: "Spam")
        menuTVC.dataDictionary = ["Inbox":[Email(sender: "fellow.student@asu.edu", subject: "Project Question", contents: "Hi help me please"),Email(sender: "prof@asu.edu", subject: "Homework", contents: "Hi turn it in please"),Email(sender: "alert@asu.edu", subject: "Bees", contents: "Hi help me please there are bees")], "Sent":[Email(sender: "fellow.student@asu.edu", subject: "Project Answer", contents: "Here is the answer"), Email(sender: "prof@asu.edu", subject: "Office Hours", contents: "Office hours are cancelled")], "Trash":[Email(sender: "alert@asu.edu", subject: "ASU Alert - Police Activity", contents: "Please stay away from the area"), Email(sender: "alert@asu.edu", subject: "ASU Alert - Gas Leak", contents: "There is a gas leak")]]
        
        /*
        rootTVC.emails.append(Email(sender: "fellow.student@asu.edu", subject: "Project Question", contents: "Hi help me please"))
        rootTVC.emails.append(Email(sender: "prof@asu.edu", subject: "Homework", contents: "Hi turn it in please"))
        rootTVC.emails.append(Email(sender: "alert@asu.edu", subject: "Bees", contents: "Hi help me please there are bees"))
 */
        let detailVC = splitVC.viewControllers.last as! ViewController
        
        menuTVC.delegate = detailVC
 
 
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

