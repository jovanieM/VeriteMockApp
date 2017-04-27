//
//  WorkProgressSimulator.swift
//  KodakVer3
//
//  Created by jmolas on 4/24/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class WorkProgressSimulator: NSObject {
    
    static let sharedInstance = WorkProgressSimulator()
 
    private var navigationController: UINavigationController?
    
    private var onScanCompleted: ((Bool) -> Void)? = nil
    
//    init(controller: UINavigationController, scanCompletionHander : @escaping (Bool) -> ()) {
//        self.navigationController = controller
//        self.onScanCompleted = scanCompletionHander
//    }
    
    func popUpActivityIndicatorAlert(controller: UINavigationController, scanCompletionHander : @escaping (Bool) -> ()){
        self.navigationController = controller
        self.onScanCompleted = scanCompletionHander
        
        let alertScanning = UIAlertController(title: "Scanning...", message: "\n\n", preferredStyle: .alert)
        
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .gray
        
        activityIndicator.frame = alertScanning.view.bounds
        activityIndicator.center.y = alertScanning.view.center.y + 8.0
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        alertScanning.view.addSubview(activityIndicator)
        
        activityIndicator.isUserInteractionEnabled = false
        
        activityIndicator.startAnimating()
        
        alertScanning.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (cancel) in
            
            self.cancelingTaskAlert()
           
        }))
        
        
        self.navigationController?.present(alertScanning, animated: true, completion: {
            
        })
        
        
        self.perform(#selector(self.scanningDone), with: nil, afterDelay: 4)
        self.perform(#selector(self.scanCompleted), with: nil, afterDelay: 5)
        
        
    }
    
    
    @objc private func scanningDone(){
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        
    }
    @objc private func scanCompleted(){
        
        onScanCompleted!(true)
        
    }
    private func cancelingTaskAlert(){
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.scanningDone), object: nil)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.scanCompleted), object: nil)
        
        let alertCanceling = UIAlertController(title: "Canceling...", message: "\n\n\n", preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .gray
        
        activityIndicator.frame = alertCanceling.view.bounds
        activityIndicator.center.y = alertCanceling.view.center.y + 16.0
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        alertCanceling.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        self.navigationController?.present(alertCanceling, animated: true, completion: nil)
        self.perform(#selector(self.scanCanceled), with: nil, afterDelay: 4.0)
        //
        
    }
    @objc private func scanCanceled(){
        
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Scan Canceled", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (alert: UIAlertAction) in
            
//            if self.scanCounter == 0{
//                self.touchToScanLabel.isHidden = false
//                self.imageView.isUserInteractionEnabled = true
//                
//            }
            self.scanCancelComplete()
            
        }))
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    private func scanCancelComplete(){
        self.onScanCompleted!(false)
    }



}
