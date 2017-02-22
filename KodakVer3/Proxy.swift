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
        
        proxyAddressView.isHidden = true
        portProxyView.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(Proxy.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
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
    
    func loadAlerts(){
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 40, height:40))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .gray
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert(){
        indicator.stopAnimating()
        self.dismiss(animated: true, completion: nil)
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
