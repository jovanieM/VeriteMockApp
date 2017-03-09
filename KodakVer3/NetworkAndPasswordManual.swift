//
//  WifiAndPasswordManual.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordManual: UIViewController,UITextFieldDelegate ,SecurityTypeProtocol{
    
    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var securityLabel: UILabel!
    
    var securityData: String?
    var unchecked = true
    var alert: UIAlertController!
    @IBOutlet weak var showPasswordLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
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
        
        ssidTextField.becomeFirstResponder()
        ssidTextField.tintColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1)
        
        viewPassword.isHidden = true
        showPasswordLabel.isHidden = true
        checkBox.isHidden = true
    }
    
    func setDataFromDisplay(datasent: String){
        self.securityData = datasent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "security"{
            let vc: SecurityType = segue.destination as! SecurityType
            vc.delegate = self
        }
    }
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        if unchecked{
            //checkBox.sendActions(for: .touchUpInside)
            checkBox.setImage(UIImage(named: "check_box_on"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            unchecked = false
        }else{
            checkBox.setImage(UIImage(named: "check_box_off"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            unchecked = true
        }
    }
    
    func setSecurityRowData(dataRow: String){
        securityLabel.text = dataRow
        
        if dataRow == "Open"{
            viewPassword.isHidden = true
            showPasswordLabel.isHidden = true
            checkBox.isHidden = true
        }else if dataRow == "WEP"{
            viewPassword.isHidden = false
            showPasswordLabel.isHidden = false
            checkBox.isHidden = false
        }else if dataRow == "WPA/WPA2-PSK MIX"{
            viewPassword.isHidden = false
            securityLabel.adjustsFontSizeToFitWidth = true
            showPasswordLabel.isHidden = false
            checkBox.isHidden = false
        }else if dataRow == "WPA2-PSK AES"{
            viewPassword.isHidden = false
            showPasswordLabel.isHidden = false
            checkBox.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if viewPassword.isHidden == true{
            if textField == ssidTextField{
                ssidTextField.resignFirstResponder()
                
                //check if ssid textfield is empty
                if ssidTextField.text == ""{
                    alert = UIAlertController(title: "SSID Input Error", message: "Please input SSID", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{(action: UIAlertAction!) in
                        self.alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                //check if security label is empty
                if securityLabel.text == ""{
                    alert = UIAlertController(title: "Security not selected", message: "Please select Security", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{(action: UIAlertAction!) in
                        self.alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    ssidTextField.resignFirstResponder()
                }
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SwitchNetwork") as! NetworkAndPasswordSwitchNetwork
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if viewPassword.isHidden == false{
            if textField == ssidTextField{
                passwordTextField.becomeFirstResponder()
                
                if securityLabel.text == "WEP"{
                    if passwordTextField.text == ""{
                        alert = UIAlertController(title: "Password Input Error", message: "Please confirm the password. \n - 5 or 13 characters of strings. \n - 10 or 26 characters of HEX strings.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{(action: UIAlertAction!) in
                            self.alert.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else if securityLabel.text == "WPA/WPA2-PSK MIX"{
                    if passwordTextField.text == ""{
                        alert = UIAlertController(title: "Password Input Error", message: "Please confirm the password. \n - 3 or 63 characters of strings. \n - 64 characters of HEX strings.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{(action: UIAlertAction!) in
                            self.alert.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }else{
                passwordTextField.resignFirstResponder()
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SwitchNetwork") as! NetworkAndPasswordSwitchNetwork
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return true
    }
    
    @IBAction func transitionToSwitchNetwork(_ sender: Any) {
    }
    
    @IBAction func transitionToSwitchNetwork2(_ sender: Any) {
    }
    
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set{
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: newValue!])
        }
    }
}

