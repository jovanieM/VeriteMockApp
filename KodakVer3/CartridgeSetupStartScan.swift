//
//  CartridgeSetupStartScan.swift
//  KodakVer3
//
//  Created by anarte on 28/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetupStartScan: UIViewController {

    @IBOutlet weak var startScanButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start scan button
        startScanButton.layer.cornerRadius = 15
        startScanButton.layer.borderWidth = 2
        startScanButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        //help button
        helpButton.layer.cornerRadius = 15
        helpButton.layer.borderWidth = 2
        helpButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< back", style: .plain, target: self, action: #selector(backAction))
    }
    
    func backAction(){
        let vc: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in vc{
            if aViewController is CartridgeSetup{
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
}
