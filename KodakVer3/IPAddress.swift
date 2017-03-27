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
        print("ip add 1: \(ipAdd1.text)")
        if ipAdd1.text == ""{
            ipAdd1.text = "0"
        }
    }
    
    @IBAction func ipAdd2DidChanged(_ sender: Any) {
        print("ip add 2: \(ipAdd2.text)")
        if ipAdd2.text == ""{
            ipAdd2.text = "0"
        }
    }
    
    @IBAction func ipAdd3DidChanged(_ sender: Any) {
        print("ip add 3: \(ipAdd3.text)")
        if ipAdd3.text == ""{
            ipAdd3.text = "0"
        }
    }
    
    @IBAction func ipAdd4DidChanged(_ sender: Any) {
        print("ip add 4: \(ipAdd4.text)")
        if ipAdd4.text == ""{
            ipAdd4.text = "0"
        }
    }
    
    @IBAction func subnet1DidChanged(_ sender: Any) {
        print("subnet mask 1: \(subnet1.text)")
        if subnet1.text == ""{
            subnet1.text = "0"
        }
    }
    
    @IBAction func subnet2DidChanged(_ sender: Any) {
        print("subnet mask 2: \(subnet2.text)")
        if subnet2.text == ""{
            subnet2.text = "0"
        }
    }
    
    @IBAction func subnet3DidChanged(_ sender: Any) {
        print("subnet mask 3: \(subnet3.text)")
        if subnet3.text == ""{
            subnet3.text = "0"
        }
    }
    
    @IBAction func subnet4DidChanged(_ sender: Any) {
        print("subnet mask 4: \(subnet4.text)")
        if subnet4.text == ""{
            subnet4.text = "0"
        }
    }
    
    @IBAction func default1DidChanged(_ sender: Any) {
        print("default gateway 1: \(defaultGate1.text)")
        if defaultGate1.text == ""{
            defaultGate1.text = "0"
        }
    }
    
    @IBAction func default2DidChanged(_ sender: Any) {
        print("default gateway 2: \(defaultGate2.text)")
        if defaultGate2.text == ""{
            defaultGate2.text = "0"
        }
    }
    
    @IBAction func default3DidChanged(_ sender: Any) {
        print("default gateway 3: \(defaultGate3.text)")
        if defaultGate3.text == ""{
            defaultGate3.text = "0"
        }
    }
    
    @IBAction func default4DidChanged(_ sender: Any) {
        print("default gateway 4: \(defaultGate4.text)")
        if defaultGate4.text == ""{
            defaultGate4.text = "0"
        }
    }
    
    @IBAction func dns1DidChanged(_ sender: Any) {
        print("dns address 1: \(dns1.text)")
        if dns1.text == ""{
            dns1.text = "0"
        }
    }
    
    @IBAction func dns2DidChanged(_ sender: Any) {
        print("dns address 2: \(dns2.text)")
        if dns2.text == ""{
            dns2.text = "0"
        }
    }
    
    @IBAction func dns3DidChanged(_ sender: Any) {
        print("dns address 3: \(dns3.text)")
        if dns3.text == ""{
            dns3.text = "0"
        }
    }
    
    @IBAction func dns4DidChanged(_ sender: Any) {
        print("dns address 4: \(dns4.text)")
        if dns4.text == ""{
            dns4.text = "0"
        }
    }
    
}
