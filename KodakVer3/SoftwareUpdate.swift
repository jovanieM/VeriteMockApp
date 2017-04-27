//
//  SoftwareUpdate.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SoftwareUpdate: UIViewController{
  
  @IBOutlet weak var saveSettingButton: UIButton!
  
  var alert: UIAlertController!
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadAlert()
    
    // button
    saveSettingButton.layer.cornerRadius = 20
    saveSettingButton.layer.borderWidth = 2
    saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
  }
  
  func loadAlert(){
    alert = UIAlertController(title: "Checking Software version... \n\n", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction!) in
      self.alert.dismiss(animated: true, completion: nil)
      _ = self.navigationController?.popViewController(animated: true)
    }))
    
    let indicator = UIActivityIndicatorView(frame: CGRect(x: 140, y: 80, width: 50, height: 50))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = .black
    indicator.startAnimating()
    
    alert.view.addSubview(indicator)
    present(alert, animated: true, completion: nil)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
      self.alert.dismiss(animated: true, completion: nil)
    }
  }
}
