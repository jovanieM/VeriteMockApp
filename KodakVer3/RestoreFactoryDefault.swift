//
//  RestoreFactoryDefault.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class RestoreFactoryDefault: UIViewController {
    
    @IBOutlet weak var saveSettingButton: UIButton!
    var alert: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    }
    
    func loadAlert(){
        alert = UIAlertController(title: "", message: "Are you sure you want to \n restore factory default?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Restore", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
            
            self.alert = UIAlertController(title: "Please Wait \n\n", message: "", preferredStyle: .alert)
            self.indicator = UIActivityIndicatorView(frame: CGRect(x: 140, y: 70, width: 50, height: 50))
            self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.indicator.activityIndicatorViewStyle = .whiteLarge
            self.indicator.color = UIColor.black
            
            self.alert.view.addSubview(self.indicator)
            self.indicator.startAnimating()
            self.present(self.alert, animated: true, completion: nil)
            _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.rebootAlert), userInfo: nil, repeats: false)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func rebootAlert(){
        self.dismiss(animated: true, completion: nil)
        
        alert = UIAlertController(title: "Printer rebooting...", message: "Press [OK] to close this app. Please \n restart this app after rebooting the \n printer.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
            exit(0)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        loadAlert()
    }
    
    
}
