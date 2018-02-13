//
//  ViewController.swift
//  Reminder
//
//  Created by MS1 on 2/13/18.
//  Copyright © 2018 muhAzharudheen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNService.instance.Authorize()
    }
    
    @IBAction func onTimerTapped(){
        UNService.instance.timerRequest(with: 5)
    }
    @IBAction func onDateTapped(){
        print("Date Tapped")
    }
    @IBAction func onLocationTapped(){
        print("Location Tapped")
    }

}

