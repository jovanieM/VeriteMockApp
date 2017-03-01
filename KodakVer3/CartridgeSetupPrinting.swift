//
//  CartridgeSetupPrinting.swift
//  KodakVer3
//
//  Created by anarte on 28/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetupPrinting: UIViewController{
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
        
        indicatorAction()
        
         _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(toTransition), userInfo: nil, repeats: false)        
        
    }
    
    func toTransition(){
        self.performSegue(withIdentifier: "toStartScan", sender: self)
    }
    
    func indicatorAction(){
        //indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 50, height:50))
        //indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //indicator.activityIndicatorViewStyle = .whiteLarge
        //indicator.color = UIColor.black
        
        indicator.startAnimating()
    }
    
}
