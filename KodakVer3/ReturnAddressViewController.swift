//
//  ReturnAddressViewController.swift
//  KodakVer3
//
//  Created by SQA on 04/04/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit


@available(iOS 9.0, *)
class ReturnAddressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var country: UITextField!
    
    let defaults = UserDefaults.standard
    let fnameKey = "firstname"
    let mnameKey = "middlename"
    let lnameKey = "lastname"
    let streetKey = "street"
    let cityKey = "city"
    let stateKey = "state"
    let postalCodeKey = "postalCode"
    let countryKey = "country"
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
        
        self.registerKeyboardNotifications()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ReturnAddressViewController.keyboardDidShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ReturnAddressViewController.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scroller.contentInset = contentInsets
        scroller.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scroller.contentInset = UIEdgeInsets.zero
        scroller.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.save.setTitleColor(UIColor.lightGray, for: .normal)
        self.save.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        save.isEnabled = true

        return true
    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
   
    
 
//        if (firstName.text?.isEmpty)! || (lastName.text?.isEmpty)! || (middleName.text?.isEmpty)! || (street.text?.isEmpty)! || (city.text?.isEmpty)! || (state.text?.isEmpty)! || (postalCode.text?.isEmpty)! || (country.text?.isEmpty)!
//        {
//            self.save.setTitleColor(UIColor.lightGray, for: .normal)
//            self.save.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
//            save.isEnabled = true
//        }
//                else {
//            self.save.setTitleColor(UIColor.darkGray, for: .normal)
//            self.save.layer.borderColor = UIColor.darkGray.cgColor
//            save.isEnabled = false
//            
//                    print("enabled")
//                }
//        return true
//    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        savedDatas()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        save.layer.cornerRadius = 15;
        save.layer.borderWidth = 1;
        save.layer.masksToBounds = true;
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.middleName.delegate = self
        self.street.delegate = self
        self.city.delegate = self
        self.state.delegate = self
        self.postalCode.delegate = self
        self.country.delegate = self
        
        save.setTitleColor(UIColor.darkGray, for: .normal)
        save.layer.borderColor = UIColor.darkGray.cgColor
        save.isEnabled = false
        
    }
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        defaults.set(firstName.text, forKey: fnameKey)
        defaults.set(lastName.text, forKey: lnameKey)
        defaults.set(middleName.text, forKey: mnameKey)
        defaults.set(street.text, forKey: streetKey)
        defaults.set(city.text, forKey: cityKey)
        defaults.set(state.text, forKey: stateKey)
        defaults.set(postalCode.text, forKey: postalCodeKey)
        defaults.set(country.text, forKey: countryKey)

        print(firstName)
        print(lastName)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func savedDatas () {
        firstName.text = defaults.object(forKey: fnameKey) as! String?
        lastName.text = defaults.object(forKey: lnameKey) as! String?
        middleName.text = defaults.object(forKey: mnameKey) as! String?
        street.text = defaults.object(forKey: streetKey) as! String?
        city.text = defaults.object(forKey: cityKey) as! String?
        state.text = defaults.object(forKey: stateKey) as! String?
        postalCode.text = defaults.object(forKey: postalCodeKey) as! String?
        country.text = defaults.object(forKey: countryKey) as! String?
    }
    

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.firstName {
            self.middleName.becomeFirstResponder()
        } else if textField == self.middleName {
            self.lastName.becomeFirstResponder()
        } else if textField == self.lastName {
            self.street.becomeFirstResponder()
            UIView.animate(withDuration: 0.3, animations: { self.holderView.frame.origin.y = self.holderView.frame.origin.y - self.street.frame.height })
        } else if textField == self.street {
            self.city.becomeFirstResponder()
            UIView.animate(withDuration: 0.3, animations: { self.holderView.frame.origin.y = self.holderView.frame.origin.y - self.city.frame.height })
        } else if textField == self.city {
            self.state.becomeFirstResponder()
            UIView.animate(withDuration: 0.3, animations: { self.holderView.frame.origin.y = self.holderView.frame.origin.y - self.state.frame.height })
        } else if textField == self.state {
            self.postalCode.becomeFirstResponder()
            UIView.animate(withDuration: 0.3, animations: { self.holderView.frame.origin.y = self.holderView.frame.origin.y - self.postalCode.frame.height })
        } else if textField == self.postalCode {
            self.country.becomeFirstResponder()
            UIView.animate(withDuration: 0.3, animations: { self.holderView.frame.origin.y = self.holderView.frame.origin.y - self.country.frame.height })
        } else if textField == self.country {
            self.country.resignFirstResponder()
            UIView.animate(withDuration: 0.3, animations: { self.holderView.frame.origin.y = 0 })
        }; return true
    }

    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("edited")
        return true
        
    }
    
    
    
}










