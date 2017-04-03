//
//  CartridgeSetup.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetup: UIViewController{
    
    @IBOutlet weak var saveSettingButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    }
    
    
}
