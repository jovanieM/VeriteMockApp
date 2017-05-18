//
//  PrintPhotoHomeVC.swift
//  KodakVer3
//
//  Created by jmolas on 2/14/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Photos

class PrintPhotoHomeVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
               // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    @IBAction func btnFacebook(_ sender: Any) {
     
    let fbSB = UIStoryboard(name: "Facebook", bundle: nil)
    let vc = fbSB.instantiateInitialViewController()!
    self.show(vc, sender: self)
  }

}
