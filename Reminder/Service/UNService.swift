//
//  UNService.swift
//  Reminder
//
//  Created by MS1 on 2/13/18.
//  Copyright © 2018 muhAzharudheen. All rights reserved.
//

import Foundation
import UserNotifications


final class UNService: NSObject{

    private override init() { }
    
    static let instance = UNService()
    
    private let unCenter = UNUserNotificationCenter.current()
    
    func Authorize() {
        let options : UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { [weak self] (granted, error) in
            print(error ?? "No UN Auth error")
            guard granted else {
                print("USER DENIED ACCESs")
                return
            }
            self?.configure()
        }
    }
    
    private func configure(){
        self.unCenter.delegate = self
    }
    
    func timerRequest(with interval: TimeInterval){
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default()
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        unCenter.add(request)
        
    }
    
    func dateRequest(with components: DateComponents){
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "it is now the future!"
        content.sound = .default()
        content.badge = 1
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        unCenter.add(request)
    }
    
    func locationRequest(){
        
    }
    
}

extension UNService: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
}
    
