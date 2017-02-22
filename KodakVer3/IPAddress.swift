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
    
    var alert: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    //navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        //automatic segue to next screen
        //_ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
        
        // hide views
        hideViews()
        
        //button
        saveSettingButton.layer.cornerRadius = 15
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
    
    func hideViews(){
        viewIpAddress.isHidden = true
        viewSubnetMask.isHidden = true
        viewDefaultGateway.isHidden = true
        viewDnsAddress.isHidden = true
    }
    
    func loadAlerts(){
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 40, height:40))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .gray
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
        
     }
    
    func dismissAlert(){
        indicator.stopAnimating()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
