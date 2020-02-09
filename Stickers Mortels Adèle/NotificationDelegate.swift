//
//  NotificationDelegate.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 23/01/2020.
//  Copyright © 2020 Bayard Presse. All rights reserved.
//

import UIKit
import Batch

@objc
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // BatchPush.handle(userNotificationCenter: center, didReceive: response)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // BatchPush.handle(userNotificationCenter: center, willPresent: notification, willShowSystemForegroundAlert: true)
        completionHandler([.alert, .sound, .badge])
    }
}
