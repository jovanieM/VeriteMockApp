//
//  PrivacyPolicyViewController.swift
//  KodakVer3
//
//  Created by SQA on 17/05/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var privacyPolicyWebview: UIWebView!
    
    let reachability = Reachability()
    
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

    
        if reachability.isConnectedToNetwork() {
            print("internet availble")
            let url = NSURL(string: "http://www.kodakverite.com/privacy-policy")
            let requestObj = NSURLRequest(url: url as! URL)
            privacyPolicyWebview.loadRequest(requestObj as URLRequest)

        } else {
            print("internet unavailable")
            let alert = UIAlertView(title: "Communication failure", message: nil, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
        
           }

   
    
}
