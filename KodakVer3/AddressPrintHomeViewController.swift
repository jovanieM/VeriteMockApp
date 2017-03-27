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
    @IBAction func Photo(_ sender: Any) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoadInstructionsViewController") as? LoadInstructionsViewController
        
        NextViewController?.dataNameReceived = "Photo"
        NextViewController?.dataDescReceived = "4 3/4\" x 6 1/2\""
        self.navigationController?.pushViewController(NextViewController!, animated: true)
        
    }
    
    @IBAction func No6(_ sender: Any) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoadInstructionsViewController") as? LoadInstructionsViewController
        
        NextViewController?.dataNameReceived = "No. 6 3/4"
        NextViewController?.dataDescReceived = "3 5/8\" x 6 1/2\""
        self.navigationController?.pushViewController(NextViewController!, animated: true)
    }
    
    
    @IBAction func No10(_ sender: Any) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoadInstructionsViewController") as? LoadInstructionsViewController
        
        NextViewController?.dataNameReceived = "No. 10"
        NextViewController?.dataDescReceived = "4 1/8\" x 9 1/2\""
        self.navigationController?.pushViewController(NextViewController!, animated: true)
    }
    
    @IBAction func SixByNine(_ sender: Any) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoadInstructionsViewController") as? LoadInstructionsViewController
        
        NextViewController?.dataNameReceived = "6x9"
        NextViewController?.dataDescReceived = "6\" x 9\""
        self.navigationController?.pushViewController(NextViewController!, animated: true)
    }
   
    
}
