//
//  CartridgeSetupScanning.swift
//  KodakVer3
//
//  Created by anarte on 28/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CartridgeSetupScanning: UIViewController{

    var alert: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scanningLabel: UILabel!
    @IBOutlet weak var scanningImageView: UIImageView!
    
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
        self.navigationItem.leftBarButtonItem?.title = ""
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(loadAlert), userInfo: nil, repeats: false)
    }
    
    func loadAlert(){
        
        scanningLabel.isHidden = true
        scanningImageView.isHidden = true
        
        alert = UIAlertController(title: "", message: "Cartridge Setup Complete.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(loadAlert_2), userInfo: nil, repeats: false)
    }
    
    func loadAlert_2(){
        self.dismiss(animated: true, completion: nil)        
        
        let vc: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in vc{
            if aViewController is PrinterUtilityHome{
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
}
