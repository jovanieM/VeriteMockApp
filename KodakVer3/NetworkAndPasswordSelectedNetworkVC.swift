//
//  NetworkAndPasswordSelectedNetworkVC.swift
//  KodakVer3
//
//  Created by anarte on 10/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordSelectedNetworkVC: UIViewController {

    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
        
        self.navigationItem.leftBarButtonItem?.title = ""
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // help button border
        helpButton.layer.cornerRadius = 15
        helpButton.layer.borderWidth = 2
        helpButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        // other button border
        otherButton.layer.cornerRadius = 15
        otherButton.layer.borderWidth = 2
        otherButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    }

    @IBAction func otherBtnPressed(_ sender: UIButton) {
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectTheNetwork") as! NetworkAndPasswordSelectTheNetwork
        //self.navigationController!.popToViewController(vc, animated: true)
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == passwordTextField{
        passwordTextField.resignFirstResponder()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SwitchNetwork") as! NetworkAndPasswordSwitchNetwork
        self.navigationController?.pushViewController(vc, animated: true)
        
        //let vc = UIStoryboard(name: "WiFiSetupStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SwitchNetwork") as! NetworkAndPasswordSelectTheNetwork
        //self.navigationController?.pushViewController(vc, animated: true)
        }
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
