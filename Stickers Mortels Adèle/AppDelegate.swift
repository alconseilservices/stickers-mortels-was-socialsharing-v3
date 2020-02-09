//
//  AppDelegate.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 18/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//

import UIKit
import FirebaseCore
import Batch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var notificationDelegate = NotificationDelegate()
    var center = UNUserNotificationCenter.current()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // BatchPush.disableAutomaticIntegration()
        Batch.start(withAPIKey: "DEV56E6C3FDD1D50248213DCDB910F") // dev
        // Batch.start(withAPIKey: "56E6C3FDCEAC5B0F3D6AAEA38CB6AC") // live
        BatchPush.requestNotificationAuthorization()
        BatchPush.refreshToken()
        
        self.center.delegate = self.notificationDelegate
        
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    /*
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        BatchPush.handleRegister(notificationSettings)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        BatchPush.handleDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        BatchPush.handleNotification(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        BatchPush.handleNotification(userInfo)
        completionHandler(.newData) // Adjust the result accordingly
    }

    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        BatchPush.handleNotification(userInfo, actionIdentifier: identifier)
        completionHandler()
    }
 */
}

