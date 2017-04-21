//
//  CartridgeSetup.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetup: UIViewController{
  
  @IBOutlet weak var saveSettingButton: UIButton!
  @IBOutlet weak var desc1: UILabel!
  @IBOutlet weak var desc2: UILabel!
  @IBOutlet weak var desc3: UILabel!
  @IBOutlet weak var viewPrinting: UIView!
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // show views
    desc1.isHidden = false
    desc2.isHidden = false
    saveSettingButton.isHidden = false
    
    // button
    saveSettingButton.layer.cornerRadius = 25
    saveSettingButton.layer.borderWidth = 2
    saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    
    
  }
  
  //  @IBAction func btnStartCartridgeSetup(_ sender: UIButton) {
  //
  //    // hide views
  //    desc1.isHidden = true
  //    desc2.isHidden = true
  //    saveSettingButton.isHidden = true
  //
  //    // show views
  //    desc3.isHidden = false
  //    viewPrinting.isHidden = false
  //
  //    // hide back button
  //    self.navigationItem.leftBarButtonItem?.title = ""
  //    self.navigationItem.leftBarButtonItem?.isEnabled = false
  //
  //    //animate uiactivityindicatorview
  //    indicator.startAnimating()
  //
  //    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(toTransition), userInfo: nil, repeats: false)
  //  }
  //
  //  func toTransition(){
  //    self.performSegue(withIdentifier: "toStartScan", sender: self)
  //  }
  
}
