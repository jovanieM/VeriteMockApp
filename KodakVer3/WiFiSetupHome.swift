//
//  WiFiSetup.swift
//  KodakVer3
//
//  Created by anarte on 14/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class WiFiSetupHome: UIViewController{
    
    //navigation controller
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
}
