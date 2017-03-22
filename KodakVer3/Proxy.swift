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
    @IBOutlet weak var proxyTopView: UIView!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
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
        
        // hide view
        proxyAddressView.isHidden = true
        portProxyView.isHidden = true
        
        // dismiss soft keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(Proxy.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        portTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = CharacterSet.decimalDigits.inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
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
    
    func loadAlerts(){
        proxyTopView.isHidden = true
        saveSettingButton.isHidden = true
        
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
