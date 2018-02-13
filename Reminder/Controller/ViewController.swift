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
        AlertService.actinSheet(in: self, title: "5 seconds") {
            UNService.instance.timerRequest(with: 5)
        }
    }
    @IBAction func onDateTapped(){
        AlertService.actinSheet(in: self, title: "Some Future Tiem.") {
            var components = DateComponents()
            components.second = 0
            UNService.instance.dateRequest(with: components)
        }
    }
    @IBAction func onLocationTapped(){
        AlertService.actinSheet(in: self, title: "When I return") {
            
        }
    }

}

