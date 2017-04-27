//
//  CopyViewController.swift
//  KodakVer3
//
//  Created by SQA on 15/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CopyViewController: UIViewController {
  
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var numcopies: UITextView!
  @IBOutlet weak var standardA4bw: UIButton!
  @IBOutlet weak var standardA4color: UIButton!
  @IBOutlet weak var custom: UIButton!
  @IBOutlet weak var viewStandard: UIView!
  @IBOutlet weak var viewCustom: UIView!
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stepper.autorepeat = true
    stepper.maximumValue = 99
    stepper.minimumValue = 1
    
    numcopies.isEditable = false
    numcopies.isSelectable = false
  }
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    numcopies.text  = Int(sender.value).description
  }
  
  @IBAction func standardcolorButtonSelect(_ sender: Any) {
    standardA4color.setBackgroundImage(#imageLiteral(resourceName: "copysetting_select"), for: .normal)
    standardA4bw.setBackgroundImage(#imageLiteral(resourceName: "copysetting_unselect"), for: .normal)
    custom.setBackgroundImage(#imageLiteral(resourceName: "copysetting_unselect"), for: .normal)
    self.viewStandard.alpha = 1.0
    self.viewCustom.alpha = 0.0
  }
  
  @IBAction func standardbwButtonSelect(_ sender: Any) {
    
    standardA4color.setBackgroundImage(#imageLiteral(resourceName: "copysetting_unselect"), for: .normal)
    standardA4bw.setBackgroundImage(#imageLiteral(resourceName: "copysetting_select"), for: .normal)
    custom.setBackgroundImage(#imageLiteral(resourceName: "copysetting_unselect"), for: .normal)
    self.viewStandard.alpha = 1.0
    self.viewCustom.alpha = 0.0
  }
  
  @IBAction func customButtonSelect(_ sender: Any) {
    
    standardA4color.setBackgroundImage(#imageLiteral(resourceName: "copysetting_unselect"), for: .normal)
    standardA4bw.setBackgroundImage(#imageLiteral(resourceName: "copysetting_unselect"), for: .normal)
    custom.setBackgroundImage(#imageLiteral(resourceName: "copysetting_select"), for: .normal)
    self.viewStandard.alpha = 0.0
    self.viewCustom.alpha = 1.0
  }
}
