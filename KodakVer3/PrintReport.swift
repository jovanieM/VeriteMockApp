//
//  PrintReport.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintReport: UIViewController {
    
    @IBOutlet weak var saveSettingButton: UIButton!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    //navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button
        saveSettingButton.layer.cornerRadius = 25
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    }
    
    @IBAction func startPrintingActionButton(_ sender: UIButton) {
        alert = UIAlertController(title: "Printing... \n\n", message: "", preferredStyle: .alert)
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        
        alert.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        
        self.present(alert, animated: true, completion: nil)
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
    }
    
    func dismissAlert_2(){
        self.alert?.dismiss(animated: true, completion: nil)
        _ = self.navigationController?.popViewController(animated: true)
    }    
}
