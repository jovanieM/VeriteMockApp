//
//  AddressPrintHomeViewController.swift
//  KodakVer3
//
//  Created by SQA on 23/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class AddressPrintHomeViewController: UIViewController {

    @IBOutlet weak var addReturnAddressCheckbox: UIImageView!
    
    @IBOutlet weak var doNotShowInstructionsCheckbox: UIImageView!
    
    let checked = UIImage(named: "check_box_off")
    let unchecked = UIImage(named: "check_box_on_orange")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func AddReturnAddressButton(_ sender: Any) {
        
        if addReturnAddressCheckbox.image == checked {
            addReturnAddressCheckbox.image = unchecked
        } else {
            addReturnAddressCheckbox.image = checked
        }
    }
   
    @IBAction func DoNotShowInstructionsButton(_ sender: Any) {
        
        if doNotShowInstructionsCheckbox.image == checked {
            doNotShowInstructionsCheckbox.image = unchecked
        } else {
            doNotShowInstructionsCheckbox.image = checked
        }
    }
    
}
