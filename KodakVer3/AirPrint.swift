//
//  AirPrint.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class AirPrint: UIViewController {

    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var airprintSwitcher: UISwitch!
    @IBOutlet weak var enableDisableLabel: UILabel!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    let airprintDefaults = UserDefaults.standard
    let switchKey = "switcher"
    let airprintLabelKey = "enableDisable"
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
        if(airprintDefaults.bool(forKey: switchKey)){
            airprintSwitcher.isOn = true
        }else{
            airprintSwitcher.isOn = false
        }
        
        if let enableDisable = airprintDefaults.object(forKey: airprintLabelKey) as? String{
            enableDisableLabel.text = enableDisable
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        //button oval border
        saveSettingButton.layer.cornerRadius = 20
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 254/255, green: 169/255, blue: 10/255, alpha: 1).cgColor
        
        UserDefaults.standard.register(defaults: [switchKey: false])
    }
    
    @IBAction func airprintActionSwitcher(_ sender: UISwitch) {
        if airprintSwitcher.isOn == true{
            enableDisableLabel.text = "Enable"
        } else {
            enableDisableLabel.text = "Disable"
        }
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        if airprintDefaults.value(forKey: switchKey) != nil{
            let val: Bool = airprintDefaults.value(forKey: switchKey) as! Bool
            if val == airprintSwitcher.isOn{
            
            }else{
                airprintDefaults.set(airprintSwitcher.isOn, forKey: switchKey)
                airprintDefaults.set(enableDisableLabel.text, forKey: airprintLabelKey)
                
                alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
                
                indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
                indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                indicator.activityIndicatorViewStyle = .whiteLarge
                indicator.color = .black
                
                alert.view.addSubview(indicator)
                indicator.isUserInteractionEnabled = false
                indicator.startAnimating()
                
                self.present(alert, animated: true, completion: nil)
                _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
            }
        }
        
        
    }
    
    func loadAlerts(){       
        
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 50, height:50))
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
