//
//  ReturnAddressViewController.swift
//  KodakVer3
//
//  Created by SQA on 04/04/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ReturnAddressViewController: UIViewController {

    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var country: UITextField!
    
    
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
        
        save.layer.cornerRadius = 15;
        save.layer.borderWidth = 1;
        save.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        save.layer.masksToBounds = true;
    }

}
