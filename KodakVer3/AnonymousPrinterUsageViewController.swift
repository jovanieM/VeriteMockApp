//
//  AnonymousPrinterUsageViewController.swift
//  KodakVer3
//
//  Created by SQA on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class AnonymousPrinterUsageViewController: UIViewController {

    @IBOutlet weak var agreeButton: UIButton!
    
    @IBOutlet weak var savesettingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        savesettingButton.layer.cornerRadius = 15;
        savesettingButton.layer.borderWidth = 1;
        savesettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        savesettingButton.layer.masksToBounds = true;
    
        
                let alert: UIAlertView = UIAlertView(title: nil, message: "Getting printer setting...", delegate: self, cancelButtonTitle: "Cancel");
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x:95, y:90, width:40, height:40)) as UIActivityIndicatorView
                loadingIndicator.center = self.view.center;
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                loadingIndicator.startAnimating();
                alert.setValue(loadingIndicator, forKey: "accessoryView");
                alert.show();
        
        
        
        
                   //     let alertnext: UIAlertView = UIAlertView(title: nil, message: "Copy Canceled.", delegate: self, cancelButtonTitle: "OK");
        
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when) {
                alert.dismiss(withClickedButtonIndex:-1, animated: true)
                }

    
    }

    
    @IBAction func acceptButton(_ sender: Any) {
        
        if (agreeButton.isSelected == true)
        {
            agreeButton.setImage(#imageLiteral(resourceName: "checkmark_large"), for: .normal)
            agreeButton.isSelected = false;
        }
        else{
            agreeButton.setImage(#imageLiteral(resourceName: "checkmark_list_none"), for: .normal)
            agreeButton.isSelected = true;
        }

    }
    
    @IBAction func savebuttonPressed(_ sender: Any) {
        
                let alert: UIAlertView = UIAlertView(title: nil, message: "Setting...", delegate: self, cancelButtonTitle: nil);
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x:95, y:90, width:40, height:40)) as UIActivityIndicatorView
                loadingIndicator.center = self.view.center;
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                loadingIndicator.startAnimating();
                alert.setValue(loadingIndicator, forKey: "accessoryView");
                alert.show();
        
        
        
        
                   //     let alertnext: UIAlertView = UIAlertView(title: nil, message: "Copy Canceled.", delegate: self, cancelButtonTitle: "OK");
        
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                alert.dismiss(withClickedButtonIndex:-1, animated: true)
                    
                    let AnonymousPrinterUsageSB = UIStoryboard(name: "TermsConditionsStoryboard", bundle: nil)
                    let vc = AnonymousPrinterUsageSB.instantiateInitialViewController()!
                    self.show(vc, sender: self)
                }
        
        

    }
    
    
    
}
