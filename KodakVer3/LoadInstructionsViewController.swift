//
//  LoadInstructionsViewController.swift
//  KodakVer3
//
//  Created by SQA on 24/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts

@available(iOS 9.0, *)
class LoadInstructionsViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var OKbutton: UIButton!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var envelopeImage: UIImageView!
    
    @IBOutlet weak var envelopeName: UILabel!
    @IBOutlet weak var envelopeDescription: UILabel!
    
    var test = "testing"

    var dataNameReceived: String = ""
    var dataDescReceived: String = ""
    var dataImage: UIImage!

    var street: String = ""
    var city: String = ""
    var state: String = ""
    var postalCode: String = ""
    var country: String = ""
    var isoCountry: String = ""
    var getAddress: String = ""
    
    var selectedContact: CNContactProperty = CNContactProperty()
  
    
    let animationImages1:[UIImage] = [UIImage(named: "ap_setenvelope04")!,
                                       UIImage(named: "ap_setenvelope04")!,
                                       UIImage(named: "ap_setenvelope05")!,
                                       UIImage(named: "ap_setenvelope06")!,
                                       UIImage(named: "ap_setenvelope07")!,
                                       UIImage(named: "ap_setenvelope08")!,
                                       UIImage(named: "ap_setenvelope09")!,
                                       UIImage(named: "ap_setenvelope10")!,
                                       UIImage(named: "ap_setenvelope11")!,
                                       UIImage(named: "ap_setenvelope12")!,
                                       UIImage(named: "ap_setenvelope13")!,
                                       UIImage(named: "ap_setenvelope13")!,
                                       UIImage(named: "ap_setenvelope13")!,
                                       UIImage(named: "ap_setenvelope14")!,
                                       UIImage(named: "ap_setenvelope15")!,
                                       UIImage(named: "ap_setenvelope16")!,
                                       UIImage(named: "ap_setenvelope17")!,
                                       UIImage(named: "ap_setenvelope18")!,
                                       UIImage(named: "ap_setenvelope18")!,
                                       UIImage(named: "ap_setenvelope18")!]
    
    
    let animationImages2:[UIImage] = [UIImage(named: "ap_setenvelope04")!,
                                      UIImage(named: "ap_setenvelope04")!,
                                      UIImage(named: "ap_setenvelope04")!,
                                      UIImage(named: "ap_setenvelope05")!,
                                      UIImage(named: "ap_setenvelope06")!,
                                      UIImage(named: "ap_setenvelope07")!,
                                      UIImage(named: "ap_setenvelope08")!,
                                      UIImage(named: "ap_setenvelope09")!,
                                      UIImage(named: "ap_setenvelope69-10")!,
                                      UIImage(named: "ap_setenvelope69-11")!,
                                      UIImage(named: "ap_setenvelope69-12")!,
                                      UIImage(named: "ap_setenvelope69-13")!,
                                      UIImage(named: "ap_setenvelope69-13")!,
                                      UIImage(named: "ap_setenvelope69-13")!,
                                      UIImage(named: "ap_setenvelope69-14")!,
                                      UIImage(named: "ap_setenvelope69-15")!,
                                      UIImage(named: "ap_setenvelope69-16")!,
                                      UIImage(named: "ap_setenvelope69-17")!,
                                      UIImage(named: "ap_setenvelope69-18")!,
                                      UIImage(named: "ap_setenvelope69-18")!,
                                      UIImage(named: "ap_setenvelope69-18")!]
    
   
    
    
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

        envelopeName.text = dataNameReceived
        envelopeDescription.text = dataDescReceived
        envelopeImage.image = dataImage
        OKbutton.layer.cornerRadius = 15;
        OKbutton.layer.borderWidth = 1;
        OKbutton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        OKbutton.layer.masksToBounds = true;
        
        if dataNameReceived == "6x9" {
            loadingImageView.animationImages = animationImages2
            
        } else {
            loadingImageView.animationImages = animationImages1
            
        }
        loadingImageView.animationDuration = 15.0
        loadingImageView.animationRepeatCount = 0
        loadingImageView.startAnimating()
        self.view.addSubview(loadingImageView)
        
        

    }
    
    
    
    @available(iOS 9.0, *)
    @IBAction func OKbuttonpressed(_ sender: Any) {

        DisplayContacts()
    }

    func DisplayContacts(){
        
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        
        cnPicker.displayedPropertyKeys = [CNContactPostalAddressesKey]
        self.present(cnPicker, animated: true, completion: nil)
        NSLog("contacts displayed")
 
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        
        let postalAddress = contactProperty.value as? CNPostalAddress
     
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.string(from: contact, style: .fullName)
        let contactAddress = CNPostalAddressFormatter.string(from: postalAddress!, style: .mailingAddress)
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController
        
        nextVC?.nameReceived = self.dataNameReceived
        nextVC?.descReceived = self.dataDescReceived
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

