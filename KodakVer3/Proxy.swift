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
    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var portTextField: UITextField!
    
    
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
        
        proxyAddressView.isHidden = true
        portProxyView.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(Proxy.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        saveSettingButton.layer.cornerRadius = 25
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 138/255, blue: 0/255, alpha: 1).cgColor
        
    }
    
    // uiswitch action
    @IBAction func switcher(_ sender: UISwitch) {
        if proxySwitch.isOn == true{
            onOffLabel.text = "ON"
            
            proxyAddressView.isHidden = false
            portProxyView.isHidden = false
        } else {
            onOffLabel.text = "OFF"
            
            proxyAddressView.isHidden = true
            portProxyView.isHidden = true
        }
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Settings", message: " \n ", preferredStyle: .alert)
        
        let indicator = UIActivityIndicatorView(frame: alert.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        alert.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        
        self.present(alert, animated: true, completion: nil)     
        
    }
}

/* extension UITextField {
    @IBInspectable var maxLength: Int{
        get{
            guard let length = maxLengths[self] else{
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            
            addTarget(self, action: #selector(limitLength), for: UIControlEvents.editingChanged)
        }
    }
    
    func limitLength(textField: UITextField){
        guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength else {
                return
        }
        
        let selection = selectedTextRange
        
        //text = prospectiveText.substring(with: Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.startIndex.))
        
        text = prospectiveText.substring(with: Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.startIndex(prospectiveText.startIndex, offset(from: 0, to: maxLength))))
        selectedTextRange = selection
    }
} */
