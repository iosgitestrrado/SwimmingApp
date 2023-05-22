//
//  AppDelegate.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
       
        validateSplashScreens()
        appRegisterForPushNotification(application: application)
        if UserDefaults.standard.object(forKey: "isLoggedIn") != nil{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.settabbarRootVC()
        }
        print("1")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
         print("2")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         print("3")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
         print("4")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
         print("5")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
         print("6")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{
    func settabbarRootVC(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        UIApplication.shared.keyWindow?.rootViewController = viewController
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
    }
    
    func validateSplashScreens()
    {
        if userDefaults.isKeyPresentInUserDefaults(key: "splashScreenSkipped"){
            print("aaaa")
            if userDefaults.GET_USERDEFAULTSSTATUS(objectValue: "splashScreenSkipped"){
                print("bbbb")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                window!.rootViewController = viewController
                window!.makeKeyAndVisible()
            }
        }
    }
    
    func appRegisterForPushNotification(application:UIApplication) {
        //[START register_for_notifications]
        print("appRegisterForPushNotification")
        DispatchQueue.main.async(execute:  {
            let isRegisteredNotifications = application.isRegisteredForRemoteNotifications
            if !isRegisteredNotifications{
                if UserDefaults.standard.object(forKey: "isLoggedIn") == nil{
                    self.askPermissionForPushNotification()
                    print("askPermissionForPushNotification")
                }
            }
            // Use Firebase library to configure APIs
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
            application.registerForRemoteNotifications()
            
        })
    }
    
    func askPermissionForPushNotification(){
        //[START register_for_notifications]
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
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
    }
}

extension UIApplication {
//    var statusBarView: UIView? {
//        if responds(to: Selector(("statusBar"))) {
//            return value(forKey: "statusBar") as? UIView
//        }
//        return nil
//    }
}

extension AppDelegate : MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?)
    {
        print("Firebase registration token: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
 
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    
}
