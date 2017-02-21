//
//  AnonymousPrinterUsageViewController.swift
//  KodakVer3
//
//  Created by SQA on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class AnonymousPrinterUsageViewController: UIViewController {

    @IBOutlet weak var agreeButton: UIButton!
    
    @IBOutlet weak var savesettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        savesettingButton.layer.cornerRadius = 10;
        savesettingButton.layer.borderWidth = 1;
      //  savesettingButton.layer.borderColor = UIColor.orange().CGColor
        savesettingButton.layer.masksToBounds = true;
    }

    
    @IBAction func acceptButton(_ sender: Any) {
        
        if (agreeButton.isSelected == true)
        {
            agreeButton.setImage(#imageLiteral(resourceName: "checkmark_large"), for: .normal)
            agreeButton.isSelected = false;
        }
        else{
            agreeButton.setImage(#imageLiteral(resourceName: "checkmark_list_none"), for: .normal)
            agreeButton.isSelected = true;
        }

    }
    
    
}
