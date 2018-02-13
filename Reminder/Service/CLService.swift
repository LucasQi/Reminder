//
//  CLService.swift
//  Reminder
//
//  Created by MS1 on 2/13/18.
//  Copyright © 2018 muhAzharudheen. All rights reserved.
//

import Foundation
import CoreLocation

class CLService: NSObject{
    
    private override init() {}
    
    static let instance = CLService()
    
    let locationManager = CLLocationManager()
    
    var shouldSetRegion = true
    
    func authorize(){
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocations(){
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
    
    
}

extension CLService: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got Location")
        guard let currentLocation = locations.first , shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did Enter Region via CL")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
        
    }
    
    
    
    
}
