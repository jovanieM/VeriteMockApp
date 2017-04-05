//
//  CartridgeSetupPrinting.swift
//  KodakVer3
//
//  Created by anarte on 28/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetupPrinting: UIViewController{
  
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  
  // navigation bar
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    
    self.navigationItem.leftBarButtonItem?.title = ""
    self.navigationItem.leftBarButtonItem?.isEnabled = false
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    indicatorAction()
    
    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(toTransition), userInfo: nil, repeats: false)
    
  }
  
  func toTransition(){
    self.performSegue(withIdentifier: "toStartScan", sender: self)
  }
  
  func indicatorAction(){
    indicator.startAnimating()
  }
  
}
