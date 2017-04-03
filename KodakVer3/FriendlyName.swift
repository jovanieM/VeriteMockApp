//
//  FriendlyName.swift
//  KodakVer3
//
//  Created by anarte on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class FriendlyName: UIViewController{
    
    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var friendlyNameTxt: UITextField!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var viewFriendlyName: UIView!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    //navigation controller
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        //button
        saveSettingButton.layer.cornerRadius = 20
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 254/255, green: 169/255, blue: 10/255, alpha: 1).cgColor
        
        // dismiss soft keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(FriendlyName.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let name: String? = UserDefaults.standard.object(forKey: "friendlyName") as? String
        
        if let nameToDisplay = name{
            friendlyNameTxt.text = nameToDisplay
        }
    }
    
    func loadAlerts(){
        desc.isHidden = true
        viewFriendlyName.isHidden = true
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
        alert.dismiss(animated: true, completion: nil)
    
        desc.isHidden = false
        viewFriendlyName.isHidden = false
        saveSettingButton.isHidden = false
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        friendlyNameTxt.resignFirstResponder()
        let myText = friendlyNameTxt.text
        UserDefaults.standard.set(myText, forKey: "friendlyName")
        
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
