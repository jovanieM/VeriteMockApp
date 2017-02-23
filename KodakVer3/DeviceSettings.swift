//
//  DeviceSettings.swift
//  KodakVer3
//
//  Created by anarte on 14/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class DeviceSettings: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    // transition to Network Status
    @IBAction func toNetworkStatus(_ sender: UIButton) {
        let networkStatusSB = UIStoryboard(name: "NetworkStatusStoryboard", bundle: nil)
        let vc = networkStatusSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    // transition to Wi-Fi Setup
    @IBAction func toWiFiSetup(_ sender: UIButton) {
        let wifiSetupSB = UIStoryboard(name:"WiFiSetupStoryboard", bundle: nil)
        let vc = wifiSetupSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    @IBAction func toGCP(_ sender: UIButton) {
        let gcpSB = UIStoryboard(name: "GCPStoryboard", bundle: nil)
        let vc = gcpSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    @IBAction func toAirPrint(_ sender: UIButton) {
        let airPrintSB = UIStoryboard(name: "AirPrintStoryboard", bundle: nil)
        let vc = airPrintSB.instantiateInitialViewController()!
        self.show(vc, sender: self)

    }
}
