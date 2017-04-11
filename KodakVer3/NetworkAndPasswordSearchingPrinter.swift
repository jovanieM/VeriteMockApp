//
//  NetworkAndPasswordSearchingPrinter.swift
//  KodakVer3
//
//  Created by anarte on 15/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordSearchingPrinter: UIViewController{
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // navigation controller
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //Do any additional setup after loading the view, typically from a nib
    
    self.activityIndicator.startAnimating()
 
    let time = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: time, execute: {
      self.performSegue(withIdentifier: "toSelectNetwork", sender: self)
    })
  }
}
