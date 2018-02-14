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
        if let attachment = getAttachment(for: .timer){
            content.attachments = [attachment]
        }
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
        if let attachment = getAttachment(for: .date){
            content.attachments = [attachment]
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "userNotification.date", content: content, trigger: trigger)
        unCenter.add(request)
    }
    
    func locationRequest(){
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "Welcome back silly coder you."
        content.sound = .default()
        content.badge = 1
        if let attachment = getAttachment(for: .location){
            content.attachments = [attachment]
        }
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        unCenter.add(request)
    }
    func setupActionsAndCategories(){
        
        let timerAction = UNNotificationAction(identifier: NotiificationActionID.timer.rawValue, title: "Run Timer Logic", options: [.authenticationRequired])
        let dateAction = UNNotificationAction(identifier: NotiificationActionID.date.rawValue, title: "Run Date Logic", options: [.authenticationRequired])
        let locationAction = UNNotificationAction(identifier: NotiificationActionID.location.rawValue, title: "Run Location Logic", options: [.authenticationRequired])
        
        let timerCategory = UNNotificationCategory(identifier: NotificationCategory.timer.rawValue, actions: [timerAction], intentIdentifiers: [])
        let dateCategory = UNNotificationCategory(identifier: NotificationCategory.date.rawValue, actions: [dateAction], intentIdentifiers: [])
        let locationCategory = UNNotificationCategory(identifier: NotificationCategory.location.rawValue, actions: [locationAction], intentIdentifiers: [])
        
        
        
    }
    
    
    private func getAttachment(for id: NotificationAttachmentID) -> UNNotificationAttachment?{
        var imageName:String
        
        switch id {
        case .timer : imageName = "TimeAlert"
        case .date : imageName = "DateAlert"
        case .location : imageName = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil}
        
        do {
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
        } catch {
            return nil
        }
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
    
