//
//  WifiAndPasswordManual.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordManual: UIViewController, SecurityTypeProtocol{
    
    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var securityLabel: UILabel!
    
    var securityData: String?
    
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
        
        //if  self.securityLabel.text == "Open"{
        //    viewPassword.isHidden = true
        //}else if self.securityLabel.text == "WEP"{
        //    viewPassword.isHidden = false
        //}
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
    
    func setSecurityRowData(dataRow: String){
        securityLabel.text = dataRow
        
        if dataRow == "Open"{
            viewPassword.isHidden = true
        }else if dataRow == "WEP"{
            viewPassword.isHidden = false
        }else if dataRow == "WPA/WPA2-PSK MIX"{
            viewPassword.isHidden = false
            securityLabel.adjustsFontSizeToFitWidth = true
        }else if dataRow == "WPA2-PSK AES"{
            viewPassword.isHidden = false
        }
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

