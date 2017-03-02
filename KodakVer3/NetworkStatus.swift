//
//  NetworkStatus.swift
//  KodakVer3
//
//  Created by anarte on 14/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkStatus: UIViewController{
    
    var alert: UIAlertController!    
    var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var viewSignalQuality: UIView!
    @IBOutlet weak var viewSecurity: UIView!
    @IBOutlet weak var viewIpAddress: UIView!
    @IBOutlet weak var viewMacAddress: UIView!
    
    // navigation bar
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
        
        loadAlert()
    }
    
    func loadAlert(){
    
        viewSignalQuality.isHidden = true
        viewSecurity.isHidden = true
        viewIpAddress.isHidden = true
        viewMacAddress.isHidden = true
        
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 50, height:50))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black        
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
        
    }
    
    func dismissAlert(){
        self.alert?.dismiss(animated: true, completion: nil)
        
        viewSignalQuality.isHidden = false
        viewSecurity.isHidden = false
        viewIpAddress.isHidden = false
        viewMacAddress.isHidden = false
    }
    
}
