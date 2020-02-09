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
    var inAppMsgDelegate = InAppMsgDelegate()
    var center = UNUserNotificationCenter.current()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        BatchPush.disableAutomaticIntegration()
        Batch.start(withAPIKey: "DEV56E6C3FDD1D50248213DCDB910F") // dev
        // Batch.start(withAPIKey: "56E6C3FDCEAC5B0F3D6AAEA38CB6AC") // live
        //BatchMessaging.setDelegate(inAppMsgDelegate)
        BatchPush.requestNotificationAuthorization()
        BatchPush.refreshToken()
        
        self.center.delegate = self.notificationDelegate
        
        FirebaseApp.configure()
        return true
    }


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
 
}

@objc
class InAppMsgDelegate: NSObject, BatchMessagingDelegate {
    
    func batchMessageDidTriggerAction(_ action: BatchMessageAction, messageIdentifier identifier: String?, actionIndex index: Int) {
        var dd = ""
    }
    
    func batchInAppMessageReady(message: BatchInAppMessage) {
        do {
            let vc = try BatchMessaging.loadViewController(for: message)
            BatchMessaging.present(vc)
        } catch _ as NSError {
            // Handle the error
        }
    }
    
}

