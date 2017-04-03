//
//  Proxy.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

class Proxy: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var proxySwitch: UISwitch!
    @IBOutlet weak var proxyAddressView: UIView!
    @IBOutlet weak var portProxyView: UIView!
    @IBOutlet weak var proxyTopView: UIView!
    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var indicator: UIActivityIndicatorView!
    var switchOn: Bool = false
    
    let proxyDefaults = UserDefaults.standard
    let switchKey = "switcher"
    let textFieldKey = "textfield"
    let portKey = "portKey"
    let addressKey = "addressKey"
    
    
    //navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let switcherValue: String? = proxyDefaults.object(forKey: textFieldKey) as? String
        
        if let onOffValue = switcherValue{
            onOffLabel.text = onOffValue
        }
        
        if let portTF = proxyDefaults.object(forKey: portKey) as? String{
            portTextField.text = portTF
        }
        
        if let addressTF = proxyDefaults.object(forKey: addressKey) as? String{
            addressTextField.text = addressTF
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        // initial value for Userdefault
        UserDefaults.standard.register(defaults: [switchKey:false])
        
        
        portTextField.delegate = self
        addressTextField.delegate = self
        
        // dismiss soft keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(Proxy.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //button border
        saveSettingButton.layer.cornerRadius = 25
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 254/255, green: 169/255, blue: 10/255, alpha: 1).cgColor
    }
    
    // uiswitch action
    @IBAction func switcher(_ sender: UISwitch)
    {
        updateSwitcherState()
    }
    
    func updateSwitcherState()
    {
        if proxySwitch.isOn{
            switchOn = true
            onOffLabel.text = "ON"
            proxyAddressView.isHidden = false
            portProxyView.isHidden = false
        } else {
            switchOn = false
            onOffLabel.text = "OFF"
            proxyAddressView.isHidden = true
            portProxyView.isHidden = true
        }
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton){
        if proxyDefaults.value(forKey: switchKey) != nil {
            let val: Bool = proxyDefaults.value(forKey: switchKey) as! Bool
            if val == proxySwitch.isOn
            {
//                if proxyDefaults.value(forKey: addressKey) != nil {
//                    let val1: String
//                }
                
                //exit to screen and not saved
                _ = self.navigationController?.popViewController(animated: true)
                
                //dismiss softkeyboard if activated
                addressTextField.resignFirstResponder()
                portTextField.resignFirstResponder()
                
                print ("dont save and out")
                
            }else{
                print ("save settings")
    
                //save state
                proxyDefaults.set(proxySwitch.isOn, forKey: switchKey)
                proxyDefaults.set(onOffLabel.text, forKey: textFieldKey)
                proxyDefaults.set(addressTextField.text, forKey: addressKey)
                proxyDefaults.set(portTextField.text, forKey: portKey)
                
                //dismiss softkeyboard if activated
                addressTextField.resignFirstResponder()
                portTextField.resignFirstResponder()
                
                alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
    
                indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
                indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                indicator.activityIndicatorViewStyle = .whiteLarge
                indicator.color = UIColor.black
    
                alert.view.addSubview(indicator)
                indicator.isUserInteractionEnabled = false
                indicator.startAnimating()
    
                self.present(alert, animated: true, completion: nil)
                _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
            }
        }
    }
    
    func loadAlerts(){
        proxyTopView.isHidden = true
        saveSettingButton.isHidden = true
        proxyAddressView.isHidden = true
        portProxyView.isHidden = true
        
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 50, height:50))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert(){
        self.alert?.dismiss(animated: true, completion: nil)
        
        //to display top view and button
        proxyTopView.isHidden = false
        saveSettingButton.isHidden = false
        
        if (proxyDefaults.bool(forKey: switchKey)){
            proxySwitch.isOn = true
            proxyAddressView.isHidden = false
            portProxyView.isHidden = false
        } else {
            proxySwitch.isOn = false
            proxyAddressView.isHidden = true
            portProxyView.isHidden = true
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == portTextField){
            let aSet = CharacterSet.decimalDigits.inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
