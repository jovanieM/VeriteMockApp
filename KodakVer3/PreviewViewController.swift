//
//  PreviewViewController.swift
//  KodakVer3
//
//  Created by SQA on 31/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

@available(iOS 9.0, *)
class PreviewViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var envelopeDescription: UILabel!
    @IBOutlet weak var envelopeName: UILabel!
    @IBOutlet weak var previewWindow: UIView!
    
    var nameReceived: String = ""
    var descReceived: String = ""
    var passedAddress: String = ""
    var passedName: String = ""
    
    var contact: CNContactProperty = CNContactProperty()
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenwidth = self.view.frame.size.width
        let screenheight = self.view.frame.size.height
        
        envelopeDescription.text = descReceived
        envelopeName.text = nameReceived
        self.addressLabel.text = passedAddress
        self.nameLabel.text = passedName
        addressLabel.adjustsFontSizeToFitWidth = true
        nameLabel.adjustsFontSizeToFitWidth = true
      
        
        if envelopeName.text == "Photo" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((468*0.60)/2), y: (screenheight / 2) - ((342*0.60)/2) - 67, width: 468*0.60, height: 342*0.60)
            addressLabel.frame.origin.x = previewWindow.center.x - 60
            addressLabel.frame.origin.y = (previewWindow.frame.height - addressLabel.frame.height) - 15
            nameLabel.frame.origin.x = previewWindow.center.x - 60
            nameLabel.frame.origin.y = addressLabel.frame.origin.y
            
        } else if envelopeName.text == "No. 6 3/4" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((468*0.60)/2), y: (screenheight / 2) - ((261*0.60)/2) - 67, width: 468*0.60, height: 261*0.60)
            addressLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            addressLabel.frame.origin.y = previewWindow.frame.height - (addressLabel.frame.height)
            nameLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            nameLabel.frame.origin.y = addressLabel.frame.origin.y

        } else if envelopeName.text == "No. 10" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((684*0.42)/2), y: (screenheight / 2) - ((297*0.42)/2) - 67, width: 684*0.42, height: 297*0.40)
            addressLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            addressLabel.frame.origin.y = previewWindow.frame.height - (addressLabel.frame.height)
            nameLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            nameLabel.frame.origin.y = addressLabel.frame.origin.y
            
        } else {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((432*0.48)/2), y: (screenheight / 2) - ((648*0.48)/2) - 67, width: 432*0.48, height: 648*0.48)
            addressLabel.frame.origin.x = previewWindow.frame.origin.x - 10
            addressLabel.frame.origin.y = (previewWindow.frame.height - addressLabel.frame.height) - 50
            nameLabel.frame.origin.x = previewWindow.frame.origin.x - 10
            nameLabel.frame.origin.y = addressLabel.frame.origin.y
        }
        
    
    }
    
    
}
