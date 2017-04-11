//
//  AddressPrintHomeViewController.swift
//  KodakVer3
//
//  Created by SQA on 23/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import ContactsUI

@available(iOS 9.0, *)
class AddressPrintHomeViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var addReturnAddressCheckbox: UIImageView!
    
    @IBOutlet weak var doNotShowInstructionsCheckbox: UIImageView!
    
        
    let unchecked = UIImage(named: "check_box_off")
    let checked = UIImage(named: "check_box_on_orange")
    var name: String?
    var desc: String?
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
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
        
        checkHowToLoad(dataNameReceived: "Photo", dataDescReceived: "4 3/4\" x 6 1/2\"", dataImage: UIImage(named: "icon_env_photo_noblank")!)
    }
    
    @IBAction func No6(_ sender: Any) {
        
        checkHowToLoad(dataNameReceived: "No. 6 3/4", dataDescReceived: "3 5/8\" x 6 1/2\"", dataImage: UIImage(named: "icon_env-no6-34_noblank")!)
    }
    
    
    @IBAction func No10(_ sender: Any) {
        
        checkHowToLoad(dataNameReceived: "No. 10", dataDescReceived: "4 1/8\" x 9 1/2\"", dataImage: UIImage(named: "icon_env_no10_noblank")!)
    }
    
    @IBAction func SixByNine(_ sender: Any) {
        
        checkHowToLoad(dataNameReceived: "6x9", dataDescReceived: "6\" x 9\"", dataImage: UIImage(named: "icon_env-6x9_noblank.png")!)
    }
   
    
    
    
    
    func checkHowToLoad(dataNameReceived: String, dataDescReceived: String, dataImage: UIImage) {
        
        name = dataNameReceived
        desc = dataDescReceived
        
        if doNotShowInstructionsCheckbox.image == checked {
         
            // this will display contacts
                     
                let cnPicker = CNContactPickerViewController()
                cnPicker.delegate = self
                
                cnPicker.displayedPropertyKeys = [CNContactPostalAddressesKey]
                self.present(cnPicker, animated: true, completion: nil)
                NSLog("contacts displayed")
        //    }
            
           
            
        } else {
            
            //display How to Load Instructions
            let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoadInstructionsViewController") as? LoadInstructionsViewController
            
            NextViewController?.dataNameReceived = dataNameReceived
            NextViewController?.dataDescReceived = dataDescReceived
            NextViewController?.dataImage = dataImage
            self.navigationController?.pushViewController(NextViewController!, animated: true)
            
        }
        
    }
    
            func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
            
            
            let postalAddress = contactProperty.value as? CNPostalAddress
            
            
            let contact = contactProperty.contact
            let contactName = CNContactFormatter.string(from: contact, style: .fullName)
            let contactAddress = CNPostalAddressFormatter.string(from: postalAddress!, style: .mailingAddress)
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController
            
            
            nextVC?.nameReceived = name!
            nextVC?.descReceived = desc!
            nextVC?.passedName = contactName!
            nextVC?.passedAddress = contactAddress
            self.navigationController?.pushViewController(nextVC!, animated: true)
            NSLog(contactAddress)
            NSLog(contactName!)
            
        }
        
        
        
        @available(iOS 9.0, *)
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            NSLog("Cancel Contact Picker")
        }

        
    
}



