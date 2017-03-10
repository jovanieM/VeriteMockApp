//
//  PrintPhotoHomeVC.swift
//  KodakVer3
//
//  Created by jmolas on 2/14/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Photos

class PrintPhotoHomeVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status : PHAuthorizationStatus) in
            switch status{
            case .authorized:
                print("Authorized")
            case .denied:
                print("denied")
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("restricted")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    

}
