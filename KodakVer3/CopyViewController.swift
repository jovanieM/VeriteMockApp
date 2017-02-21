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
    
    var gold: UIColor {
        return UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepper.autorepeat = true
        stepper.maximumValue = 99
        stepper.minimumValue = 1
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          
    
    }
    
    
   
}


