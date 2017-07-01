//
//  AppDelegate.swift
//  Abkao
//
//  Created by Inder on 13/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            let names = UIFont.fontNames(forFamilyName: familyName)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        //self.printFonts()
        
        IQKeyboardManager.sharedManager().enable = true
        
        //Local Notification
        
        // Request Notification Settings
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
                switch notificationSettings.authorizationStatus
                {
                case .notDetermined:
                    self.requestAuthorization(completionHandler: { (success) in
                        guard success else { return }
                        
                        // Schedule Local Notification
                    })
                    break
                case .authorized:
                    // Schedule Local Notification
                    print("Local notification has been authorized")

                    
                    break;
                case .denied:
                    print("Application Not Allowed to Display Notifications")
                }
            }
        } else {
            // Fallback on earlier versions
        }

        //
        
        
        if let data = UserDefaults.standard.data(forKey: "userinfo"),
            
            let myUserObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserI {
            
            ModelManager.sharedInstance.profileManager.userObj = myUserObj
            
        }
        
        
        if let dataSettings = UserDefaults.standard.data(forKey: "currentsetting"),
            
            let mySettingsObj = NSKeyedUnarchiver.unarchiveObject(with: dataSettings) as? Settingsl {
            
            ModelManager.sharedInstance.settingsManager.settingObj = mySettingsObj
            
        }
        
        
        
        if  ModelManager.sharedInstance.profileManager.userObj?.userID != 0  {
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "HomeControl") as! HomeControl
            let rootViewController = self.window!.rootViewController as! UINavigationController
            rootViewController.pushViewController(loginPageView, animated: true)
            self.window?.rootViewController = rootViewController
            self.window?.makeKeyAndVisible()
        }
        
        
        return true
    }
    

    // MARK: - Custom Functions
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
                if let error = error {
                    print("Request Authorization Failed (\(error), \(error.localizedDescription))")
                }
                
                completionHandler(success)
            }
        } else {
            // Fallback on earlier versions
        }
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
                
        let strDayName = NSDate().dayOfWeek()

        let strModalDayName = ModelManager.sharedInstance.scheduleManager.dayName
        
        if(strModalDayName != nil)
        {
            if(strModalDayName != strDayName)
            {
                ModelManager.sharedInstance.scheduleManager.getSchdulesByDay(strDay: strDayName!, handler: { ( arrSheduleObj, isScucess, strmessage) in
                    
                })
            }
        }
        else
        {
            
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        

        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //self.saveContext()
    }

//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//        */
//        let container = NSPersistentContainer(name: "Abkao")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                 
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

