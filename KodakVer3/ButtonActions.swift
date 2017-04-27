//
//  ButtonActions.swift
//  KodakVer3
//
//  Created by jmolas on 4/19/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import MessageUI

class ButtonActions: NSObject, MFMailComposeViewControllerDelegate{
    
    var vc = UIViewController()
    
    init(viewController : UIViewController) {
        self.vc = viewController
    }

 
    func configuredMailComposerVC(image : UIImage,  mimeSubtype : String) -> MFMailComposeViewController?{
        
        
        let fgen = FileNameGenerator()
        
        let fname = fgen.generateFileName()
        
        let mailComposerVC = MFMailComposeViewController()
        
            let dataImage = UIImagePNGRepresentation(image)
            //let data = try Data(contentsOf: url, options: Data.ReadingOptions.alwaysMapped)
            mailComposerVC.mailComposeDelegate = self
        
            mailComposerVC.setSubject(fname)
            //mailComposerVC.setMessageBody("sent from my iPhone", isHTML: false)
            
            
            mailComposerVC.addAttachmentData(dataImage!, mimeType: "image/\(mimeSubtype)", fileName: fname)
            return mailComposerVC
    
    
    }
    func saveToCameraRoll(image : UIImage){
        
        let alertScanning = UIAlertController(title: "Saving...", message: "\n\n", preferredStyle: .alert)
        
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .gray
        
        activityIndicator.frame = alertScanning.view.bounds
        activityIndicator.center.y = alertScanning.view.center.y + 8.0
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        alertScanning.view.addSubview(activityIndicator)
        
        activityIndicator.isUserInteractionEnabled = false
        
        activityIndicator.startAnimating()
        vc.navigationController?.present(alertScanning, animated: true, completion: nil)
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveToCamera), nil)

    
    }
    func dismissSaveToCam(){
        vc.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func saveToCamera(image : UIImage, didFinishSavingWithError error : NSError?, contextInfo: UnsafeRawPointer){
        guard error == nil else {
            
            return
        }
        vc.navigationController?.presentedViewController?.dismiss(animated: true, completion: {
            let alertScanning = UIAlertController(title: "Saved to camera roll", message: nil, preferredStyle: .alert)
            
            
            alertScanning.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                NSObject.cancelPreviousPerformRequests(withTarget: self)
            }))
            self.vc.navigationController?.present(alertScanning, animated: true, completion: nil)
            
        })
        
        self.perform(#selector(dismissSaveToCam), with: self, afterDelay: 2.0)
    }


    
}
