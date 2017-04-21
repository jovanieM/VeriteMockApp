//
//  DeviceSleepTime.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class DeviceSleepTime: UIViewController {
  
  var alert: UIAlertController!
  var alert2: UIAlertController!
  var indicator: UIActivityIndicatorView!
  var timeDefault = UserDefaults.standard
  
  @IBOutlet weak var saveSettingButton: UIButton!
  @IBOutlet weak var minuteTextField: UITextField!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var viewDeviceSleep: UIView!
  @IBOutlet weak var stpTime: UIStepper!
  
  // navigation bar
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadAlerts()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(Proxy.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    // button
    saveSettingButton.layer.cornerRadius = 25
    saveSettingButton.layer.borderWidth = 2
    saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    
    if let time = timeDefault.string(forKey: "time"){
      minuteTextField.text = time
      stpTime.value = Double(time)!
    }
  }
  
  func loadAlerts(){
    
    desc.isHidden = true
    viewDeviceSleep.isHidden = true
    saveSettingButton.isHidden = true
    
    alert = UIAlertController(title: "Getting Printer setting...\n\n", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
      self.dismiss(animated: true, completion: nil)
      _ = self.navigationController?.popViewController(animated: true)
    }))
    
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 50, height:50))
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
    
    desc.isHidden = false
    viewDeviceSleep.isHidden = false
    saveSettingButton.isHidden = false
  }
  
  @IBAction func deviceSleepTimeStepper(_ sender: UIStepper) {
    minuteTextField.text = Int(sender.value).description
  }
  
  func dismissKeyboard(){
    view.endEditing(true)
    
    if minuteTextField.text == "" || minuteTextField.text == "0" || minuteTextField.text == nil {
      minuteTextField.text = "1"
    }
    
    if Int(minuteTextField.text!)! > 120 {
      minuteTextField.text = "120"
    }
    
  }
  
  @IBAction func saveSettingActionButton(_ sender: UIButton) {
    
    view.endEditing(true)
    
    if minuteTextField.text == "" || minuteTextField.text == "0" || minuteTextField.text == nil {
      minuteTextField.text = "1"
    }
    
    if Int(minuteTextField.text!)! > 120 {
      minuteTextField.text = "120"
    }
    
    timeDefault.set(minuteTextField.text, forKey: "time")
    
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
  
  @IBAction func timeDidChanged(_ sender: Any) {
  }
  
}
