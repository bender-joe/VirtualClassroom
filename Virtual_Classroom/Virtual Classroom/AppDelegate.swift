//
//  AppDelegate.swift
//  Virtual Classroom
//
//  Created by Joseph Bender on 10/4/15.
//  Copyright © 2015 Vlass. All rights reserved.
//

import UIKit
<<<<<<< Updated upstream
import Bolts
import Parse
//import CoreData
=======
import CoreData
import Parse
import Bolts
>>>>>>> Stashed changes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
<<<<<<< Updated upstream
=======
        // Override point for customization after application launch.
        
>>>>>>> Stashed changes
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
<<<<<<< Updated upstream
        // Initialize Parse.
=======
>>>>>>> Stashed changes
        Parse.setApplicationId("LBTlOCwApDCeSyoavQN4gLOVgBMWTd2GFr3j5ZRR",
            clientKey: "L7YWe4TpferpK1rgqFf2XOSWfG1sv7g0BcSds7cL")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        return true

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

//    func applicationWillTerminate(application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
//    }
}

