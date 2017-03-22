//
//  IPAddress.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class IPAddress: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var switchController: UISwitch!
    @IBOutlet weak var autoManualLabel: UILabel!
    @IBOutlet weak var viewIpAddress: UIView!
    @IBOutlet weak var viewSubnetMask: UIView!
    @IBOutlet weak var viewDefaultGateway: UIView!
    @IBOutlet weak var viewDnsAddress: UIView!
    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var ipaddressTopView: UIView!
    @IBOutlet weak var ipAdd1: UITextField!
    @IBOutlet weak var ipAdd2: UITextField!
    @IBOutlet weak var ipAdd3: UITextField!
    @IBOutlet weak var ipAdd4: UITextField!
    @IBOutlet weak var subnet1: UITextField!
    @IBOutlet weak var subnet2: UITextField!
    @IBOutlet weak var subnet3: UITextField!
    @IBOutlet weak var subnet4: UITextField!
    @IBOutlet weak var defaultGate1: UITextField!
    @IBOutlet weak var defaultGate2: UITextField!
    @IBOutlet weak var defaultGate3: UITextField!
    @IBOutlet weak var defaultGate4: UITextField!
    @IBOutlet weak var dns1: UITextField!
    @IBOutlet weak var dns2: UITextField!
    @IBOutlet weak var dns3: UITextField!
    @IBOutlet weak var dns4: UITextField!
    
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
        
        // hide views
        hideViews()
        
        initTextFields()
        
        //button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IPAddress.dismissKeyboard))
        view.addGestureRecognizer(tap)        
    }
    
    func initTextFields(){
        ipAdd1.delegate = self
        ipAdd2.delegate = self
        ipAdd3.delegate = self
        ipAdd4.delegate = self
        subnet1.delegate = self
        subnet2.delegate = self
        subnet3.delegate = self
        subnet4.delegate = self
        defaultGate1.delegate = self
        defaultGate2.delegate = self
        defaultGate3.delegate = self
        defaultGate4.delegate = self
        dns1.delegate = self
        dns2.delegate = self
        dns3.delegate = self
        dns4.delegate = self
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        alert = UIAlertController(title: "If [OK] is touched, IP Address\n setting is modified, and this\n app is closed.", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.alert.dismiss(animated: true, completion: nil)
            
            self.alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
            
            self.indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
            self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.indicator.activityIndicatorViewStyle = .whiteLarge
            self.indicator.color = UIColor.black
            
            self.alert.view.addSubview(self.indicator)
            self.indicator.isUserInteractionEnabled = false
            self.indicator.startAnimating()
            
            self.present(self.alert, animated: true, completion: nil)
            _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.exitApp), userInfo: nil, repeats: false)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func switcher(_ sender: UISwitch) {
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
    
    func exitApp(){
        //UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        exit(0)
    }
    
    func hideViews(){
        viewIpAddress.isHidden = true
        viewSubnetMask.isHidden = true
        viewDefaultGateway.isHidden = true
        viewDnsAddress.isHidden = true
    }
    
    func loadAlerts(){
        ipaddressTopView.isHidden = true
        saveSettingButton.isHidden = true
        
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 40, height:40))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
     }
    
    func dismissAlert(){
        //indicator.stopAnimating()
        self.dismiss(animated: true, completion: nil)
        
        ipaddressTopView.isHidden = false
        saveSettingButton.isHidden = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = CharacterSet.decimalDigits.inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    
    @IBAction func ipAdd1DidChanged(_ sender: Any) {
        print("ipAdd1: \(ipAdd1.text)")
        
//        let ipadd1: Int = Int(ipAdd1.text!)!
       
//        if ipadd1 <= 0{
//            ipAdd1.text = "0"
//        } else
//        if ipadd1 >= 256 {
//            ipAdd1.text = "255"
//        }
    }
    
    
}
