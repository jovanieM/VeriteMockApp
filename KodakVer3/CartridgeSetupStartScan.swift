//
//  CartridgeSetupStartScan.swift
//  KodakVer3
//
//  Created by anarte on 28/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetupStartScan: UIViewController {
  
  @IBOutlet weak var startScanButton: UIButton!
  @IBOutlet weak var helpButton: UIButton!
  @IBOutlet weak var animationView: UIImageView!
  
  let animationScan: [UIImage] = [UIImage(named:"setpaper01")!, UIImage(named:"setpaper02")!, UIImage(named:"setpaper03")!, UIImage(named:"setpaper04")!, UIImage(named:"setpaper05")!, UIImage(named:"setpaper06")!, UIImage(named:"setpaper07")!, UIImage(named:"setpaper08")!, UIImage(named:"setpaper09")!]
  
  // navigation bar
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //start scan button
    startScanButton.layer.cornerRadius = 20
    startScanButton.layer.borderWidth = 2
    startScanButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    
    //help button
    helpButton.layer.cornerRadius = 20
    helpButton.layer.borderWidth = 2
    helpButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    
    let attrs: [String: Any] = [NSForegroundColorAttributeName: UIColor.gold, NSFontAttributeName: UIFont(name: "Arial", size: 12)!]
    
    let item: UIBarButtonItem = UIBarButtonItem(title: "< back", style: .plain, target: self, action: #selector(backAction))
    item.setTitleTextAttributes(attrs, for: .normal)
    navigationItem.leftBarButtonItem = item
    
    animationView.animationImages = animationScan
    animationView.animationDuration = 10.0
    animationView.animationRepeatCount = 0
    animationView.startAnimating()
    self.view.addSubview(animationView)
  }
  
  func backAction(){
    let vc: [UIViewController] = self.navigationController!.viewControllers
    for aViewController in vc{
      if aViewController is CartridgeSetup{
        self.navigationController!.popToViewController(aViewController, animated: true)
      }
    }
  }
  
}
