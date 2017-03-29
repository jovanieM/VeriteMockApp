//
//  NetworkAndPasswordSwitchNetwork.swift
//  KodakVer3
//
//  Created by anarte on 08/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordSwitchNetwork: UIViewController {

    var alert:UIAlertController!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //navigation controller
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
        self.navigationItem.leftBarButtonItem?.title = ""
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadAlert()
    }

    func loadAlert(){
        alert = UIAlertController(title: "App is closed", message: "If [OK] is touched, the network of the \n printer is switched, and this app is \n closed. \n Please switch the network of your \n mobile manually and restart the app.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction!) in
            
            let vc: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in vc{
                if aViewController is WiFiSetupHome{
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            self.alert.dismiss(animated: true, completion: nil)
            
            self.indicator.startAnimating()
            
            _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.exitApp), userInfo: nil, repeats: false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func exitApp(){
        exit(0)
    }
}
