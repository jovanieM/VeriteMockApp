//
//  NetworkAndPasswordSearchingPrinter.swift
//  KodakVer3
//
//  Created by anarte on 15/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class NetworkAndPasswordSearchingPrinter: UIViewController{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        //Do any additional setup after loading the view, typically from a nib
        
        self.activityIndicator.startAnimating()
        
        //automatic segue to next screen
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(toTransition), userInfo: nil, repeats: false)
    }
    
    func toTransition(){
        self.performSegue(withIdentifier: "toSelectNetwork", sender: self)
    }
    
}
