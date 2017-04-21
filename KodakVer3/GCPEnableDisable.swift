//
//  GCPEnableDisable.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol EnableDisableProtocol{
    func sendValue(data: String)
}

class GCPEnableDisable: UIViewController {
    
    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var gcpSwitcher: UISwitch!
    @IBOutlet weak var gcpEnableDisableLabel: UILabel!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var indicator: UIActivityIndicatorView!
    var delegate: EnableDisableProtocol? = nil
    
    let gcpDefaults = UserDefaults.standard
    let switchKey = "switcher"
    let switchLabelKey = "textfield"
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
        if (gcpDefaults.bool(forKey: switchKey)){
            gcpSwitcher.isOn = true
        }else{
            gcpSwitcher.isOn = false
        }
        
        if let enableDisable = gcpDefaults.object(forKey: switchLabelKey) as? String{
            gcpEnableDisableLabel.text = enableDisable
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        //button oval border
        saveSettingButton.layer.cornerRadius = 25
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        //initial value for Userdefault
        UserDefaults.standard.register(defaults: [switchKey: true])
    }
    
    func loadAlerts(){
        alert = UIAlertController(title: "Status Loading...\n\n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140, y: 80, width: 50, height:50))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = .black
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert(){
        self.alert?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func gcpActionSwitcher(_ sender: UISwitch) {
        if gcpSwitcher.isOn{
            gcpEnableDisableLabel.text = "Enable"
        } else {
            gcpEnableDisableLabel.text = "Disable"
        }
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        if gcpDefaults.value(forKey: switchKey) != nil{
            let val: Bool = gcpDefaults.value(forKey: switchKey) as! Bool
            if val == gcpSwitcher.isOn{
              // no action
                print("don't save")
            }else{
                print("save")
                gcpDefaults.set(gcpSwitcher.isOn, forKey: switchKey)
                gcpDefaults.set(gcpEnableDisableLabel.text, forKey: switchLabelKey)
                
                if delegate != nil{
                    delegate?.sendValue(data: gcpDefaults.value(forKey: switchLabelKey) as! String)
                }
                
                alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
                
                indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
                indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                indicator.activityIndicatorViewStyle = .whiteLarge
                indicator.color = .black
                
                alert.view.addSubview(indicator)
                indicator.startAnimating()
                
                self.present(alert, animated: true, completion: nil)
                _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
            }
        }
    }
    
    func dismissAlert_2(){
        self.alert?.dismiss(animated: true, completion: {
            self.alert2 = UIAlertController(title: "", message: "Setting is saved", preferredStyle: .alert)
            self.present(self.alert2, animated: true, completion: {
                //self.alert2?.dismiss(animated: true, completion: nil)
                _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissAlert_3), userInfo: nil, repeats: false)
            })
        })
    }
    
    func dismissAlert_3(){
        self.alert2?.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
}
