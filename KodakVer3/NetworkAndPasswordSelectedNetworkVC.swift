//
//  NetworkAndPasswordSelectedNetworkVC.swift
//  KodakVer3
//
//  Created by anarte on 10/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordSelectedNetworkVC: UIViewController, UITextFieldDelegate, SelectNetworkProtocol{

    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ssidLabel: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    var networkData: String?
    var unchecked = true
    
    var vc = UIStoryboard(name: "WiFiSetupStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SelectedNetwork") as! NetworkAndPasswordSelectTheNetwork
    
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
        
        self.navigationItem.leftBarButtonItem?.title = ""
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // help button border
        helpButton.layer.cornerRadius = 25
        helpButton.layer.borderWidth = 2
        helpButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        // other button border
        otherButton.layer.cornerRadius = 25
        otherButton.layer.borderWidth = 2
        otherButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        ssidLabel.text = networkData
        passwordTextField.becomeFirstResponder()
        passwordTextField.tintColor = UIColor(red: 255, green: 153, blue: 0, alpha: 1)
        
        vc.delegate = self
    }
    
    func setDataFromDisplay(dataSent: String){
        self.networkData = dataSent
    }
    
    func setSelectNetworkData(dataRow: String) {
        ssidLabel.text = dataRow
    }
   
    @IBAction func otherBtnPressed(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkBox(_ sender: UIButton) {
        if unchecked{
            checkbox.setImage(UIImage(named: "check_box_on"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            unchecked = false
        } else {
            checkbox.setImage(UIImage(named: "check_box_off"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            unchecked = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == passwordTextField{
            passwordTextField.resignFirstResponder()
        
            let vc = UIStoryboard(name: "WiFiSetupStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SwitchNetwork") as! NetworkAndPasswordSwitchNetwork
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return true
    }
}
