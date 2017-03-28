//
//  AnonymousPrinterUsageViewController.swift
//  KodakVer3
//
//  Created by SQA on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class AnonymousPrinterUsageViewController: UIViewController {

    @IBOutlet weak var checkboxImage: UIImageView!
    
    @IBOutlet weak var savesettingButton: UIButton!
    
    @IBOutlet weak var checkboxButton: UIButton!
   
    var isboxClicked: Bool!
    
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


        savesettingButton.layer.cornerRadius = 15;
        savesettingButton.layer.borderWidth = 1;
        savesettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        savesettingButton.layer.masksToBounds = true;
        
 /*
        
                let alert: UIAlertView = UIAlertView(title: nil, message: "Getting printer setting...", delegate: self, cancelButtonTitle: "Cancel");
        
        let AnonymousPrinterUsageSB = UIStoryboard(name: "TermsConditionsStoryboard", bundle: nil)
        let vc = AnonymousPrinterUsageSB.instantiateInitialViewController()!
        self.show(vc, sender: self)

        
        
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x:95, y:90, width:40, height:40)) as UIActivityIndicatorView
                loadingIndicator.center = self.view.center;
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
                loadingIndicator.color = UIColor.gray
               loadingIndicator.startAnimating();
                alert.setValue(loadingIndicator, forKey: "accessoryView");
                alert.show();
        
        
                let when = DispatchTime.now() + 4
                DispatchQueue.main.asyncAfter(deadline: when) {
                alert.dismiss(withClickedButtonIndex:-1, animated: true)
                    
                    
                }
 
 
 */
        
        let alert = UIAlertController(title: nil, message: "Getting printer setting... \n \n", preferredStyle: .alert)
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 40, height:40))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.gray
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
            _ = self.navigationController?.popViewController(animated: true)
            
//            let AnonymousPrinterUsageSB = UIStoryboard(name: "TermsConditionsStoryboard", bundle: nil)
//            let vc = AnonymousPrinterUsageSB.instantiateInitialViewController()!
//            self.navigationController?.pushViewController(vc, animated: true)
//            //self.show(vc, sender: self)
        }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 4.0
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
 
    }
    
    
    
    
    @IBAction func acceptButton(_ sender: UIButton) {
        
        if(checkboxImage.image == UIImage(named: "check_box_off")){
            checkboxImage.image = UIImage(named: "check_box_on_orange")
        } else {
            checkboxImage.image = UIImage(named: "check_box_off")
        }
        
        
    }

    
    
    @IBAction func savebuttonPressed(_ sender: Any) {
        
                let alert: UIAlertView = UIAlertView(title: nil, message: "Setting...", delegate: self, cancelButtonTitle: nil);
                let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x:95, y:90, width:40, height:40)) as UIActivityIndicatorView
                loadingIndicator.center = self.view.center;
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
                loadingIndicator.color = UIColor.gray
                loadingIndicator.startAnimating();
                alert.setValue(loadingIndicator, forKey: "accessoryView");
                alert.show();
        
        
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when) {
                alert.dismiss(withClickedButtonIndex:-1, animated: true)
                    
                      _ = self.navigationController?.popViewController(animated: true)
                }
  
    }
}
