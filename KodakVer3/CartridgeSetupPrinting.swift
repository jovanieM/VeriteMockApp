//
//  CartridgeSetupPrinting.swift
//  KodakVer3
//
//  Created by anarte on 28/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetupPrinting: UIViewController{
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
        //self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(toTransition), userInfo: nil, repeats: false)
    }
    
    func toTransition(){
        self.performSegue(withIdentifier: "toStartScan", sender: self)
    }
}
