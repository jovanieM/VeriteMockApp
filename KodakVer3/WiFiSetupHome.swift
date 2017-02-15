//
//  WiFiSetup.swift
//  KodakVer3
//
//  Created by anarte on 14/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class WiFiSetupHome: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
}
