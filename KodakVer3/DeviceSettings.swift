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
    
    @IBAction func toNetworkStatus(_ sender: UIButton) {
        let settingSB = UIStoryboard(name: "NetworkStatusStoryboard", bundle: nil)
        let vc = settingSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
}
