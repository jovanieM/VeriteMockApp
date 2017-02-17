//
//  IPAddress.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class IPAddress: UIViewController{

    @IBOutlet weak var switchController: UISwitch!
    
    @IBOutlet weak var autoManualLabel: UILabel!
    
    @IBOutlet weak var viewIpAddress: UIView!
    @IBOutlet weak var viewSubnetMask: UIView!
    @IBOutlet weak var viewDefaultGateway: UIView!
    @IBOutlet weak var viewDnsAddress: UIView!
    
    @IBOutlet weak var saveSettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide views
        viewIpAddress.isHidden = true
        viewSubnetMask.isHidden = true
        viewDefaultGateway.isHidden = true
        viewDnsAddress.isHidden = true
        
        //button
        saveSettingButton.layer.cornerRadius = 25
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        //text fields
  
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IPAddress.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "If [OK] is touched, IP Address setting is modified, and this app is closed.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        if switchController.isOn == true{
            autoManualLabel.text = "manual"
            
            viewIpAddress.isHidden = false
            viewSubnetMask.isHidden = false
            viewDefaultGateway.isHidden = false
            viewDnsAddress.isHidden = false
            
        } else {
            autoManualLabel.text = "auto"
            
            viewIpAddress.isHidden = true
            viewSubnetMask.isHidden = true
            viewDefaultGateway.isHidden = true
            viewDnsAddress.isHidden = true
        }
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    //navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    
}
