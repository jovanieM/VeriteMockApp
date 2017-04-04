//
//  ScanDocumentHomeVC.swift
//  KodakVer3
//
//  Created by jmolas on 4/3/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ScanDocumentHomeVC: UIViewController {
    
    
    
    @IBOutlet weak var scan: UIView!

    @IBOutlet weak var crop: UIView!
    @IBOutlet weak var send: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scan.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "selectmenu"))
        crop.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "selectmenu"))
        send.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "selectmenu"))
       
        popUpActivityIndicatorAlert()
        
    }
    
    func popUpActivityIndicatorAlert(){
        
        alertScanning = UIAlertController(title: "Scanning...", message: "\n\n", preferredStyle: .alert)
        alertScanning.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (cancel) in
            self.cancelingTaskAlert()
            
            //self.scanCanceled()
        }))
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .gray
        
        activityIndicator.frame = alertScanning.view.bounds
        activityIndicator.center.y = alertScanning.view.center.y + 8.0
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        alertScanning.view.addSubview(activityIndicator)
        
        activityIndicator.isUserInteractionEnabled = false
        
        
        activityIndicator.startAnimating()
        self.present(alertScanning, animated: false, completion: {
        
        })
        self.perform(#selector(self.scanningDone), with: nil, afterDelay: 4.0)
    
    }
    func scanningDone(){
        alertScanning.dismiss(animated: false, completion: nil)
    
    }
    
    var alertCanceling : UIAlertController!
    var alertScanning : UIAlertController!
    
    func cancelingTaskAlert(){
        
        alertCanceling = UIAlertController(title: "Canceling...", message: "\n\n\n", preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .gray
        
        activityIndicator.frame = (alertCanceling!.view.bounds)
        activityIndicator.center.y = (alertCanceling?.view.center.y)! + 16.0
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        alertCanceling?.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        self.present(alertCanceling!, animated: false, completion: nil)
        self.perform(#selector(self.scanCanceled), with: nil, afterDelay: 4.0)
        //
        
    }
    func scanCanceled(){
        alertCanceling?.dismiss(animated: false, completion: nil)
        let alert = UIAlertController(title: "Scan Canceled", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
 
}
