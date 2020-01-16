//
//  AppDelegate.swift
//  DatePicker
//
//  Created by 위의석 on 2019/12/30.
//  Copyright © 2019 Wi's Works. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized: Bool, error: Error?) in
            if !authorized {
                print("알림을 켜지 않으시면 이 앱은 쓸모가 없습니다")
            }
        }
        
        // Define Actions
        let deferAction = UNNotificationAction(identifier: "연기하기", title: "약 먹기를 연기합니다", options: [])
        let checkAction = UNNotificationAction(identifier: "기록하기", title: "지금 먹었습니다", options: [])
        
        // Add actions to a foodCategory
        let category = UNNotificationCategory(identifier: "투약안내", actions: [deferAction, checkAction], intentIdentifiers: [], options: [])
        
        // Add the foodCategory to Notification Frame
        UNUserNotificationCenter.current().setNotificationCategories([category])

        return true
    }

    func scheduleNotification() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "투약안내"
        content.body = "주인님, 약 드실 시간입니다"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "투약안내"
        
        print("Pass 0")

        guard let path = Bundle.main.path(forResource: "viread", ofType: "jpg") else {return}
        
        let url = URL(fileURLWithPath: path)
        
        print("Pass 1: \(url.path)")
        
        do {
            let attachment = try UNNotificationAttachment(identifier: "투약안내", url: url, options: nil)
            content.attachments = [attachment]
            print("Pass 2")
        } catch {
            print("The attachment could ot be loaded")
        }
        
        let reqeust = UNNotificationRequest(identifier: "투약안내", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        UNUserNotificationCenter.current().add(reqeust) { (error:Error?) in
            if let error = error {
                print("Error")
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

