//
//  UNService.swift
//  Reminder
//
//  Created by MS1 on 2/13/18.
//  Copyright © 2018 muhAzharudheen. All rights reserved.
//

import Foundation
import UserNotifications


class UNService: NSObject{

    private override init() { }
    
    static let instance = UNService()
    
    private let unCenter = UNUserNotificationCenter.current()
    
    func Authorize() {
        let options : UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No UN Auth error")
            guard granted else {
                print("USER DENIED ACCESs")
                return
            }
        }
    }
    
}
