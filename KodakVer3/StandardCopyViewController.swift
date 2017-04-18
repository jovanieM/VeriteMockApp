//
//  StandardCopyViewController.swift
//  KodakVer3
//
//  Created by SQA on 22/02/2017.
//  Copyright © 2017 mmolo. All rights reserved.
//

import UIKit

class StandardCopyViewController: UIViewController {
  
  @IBOutlet weak var copyButton: UIButton!
  
  var alert: UIAlertController!
  var indicator: UIActivityIndicatorView!
  var cancel: UIAlertAction!
  var time: DispatchTime!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    copyButton.layer.cornerRadius = 30
    copyButton.layer.borderWidth = 2
    copyButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    copyButton.layer.masksToBounds = true;
  }
  
  @IBAction func copystandardButtonPressed(_ sender: Any) {
    
    //let alert: UIAlertView = UIAlertView(title: nil, message: "Copying...", delegate: self, cancelButtonTitle: "Cancel");
    
    alert = UIAlertController(title: "Copying... \n\n", message: nil, preferredStyle: .alert)
    cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
      self.alert.dismiss(animated: true, completion: nil)
      
      self.alert = UIAlertController(title: "Canceling... \n\n", message: nil, preferredStyle: .alert)
      self.indicator = UIActivityIndicatorView(frame: CGRect(x: 140, y: 80, width: 40, height: 40))
      self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      self.indicator.activityIndicatorViewStyle = .whiteLarge
      self.indicator.color = .black
      self.alert.view.addSubview(self.indicator)
      self.indicator.startAnimating()
      self.present(self.alert, animated: true, completion: nil)
      
      self.time = DispatchTime.now() + 4.0
      DispatchQueue.main.asyncAfter(deadline: self.time){
        self.alert.dismiss(animated: true, completion: nil)
        
        self.alert = UIAlertController(title: "Copy Canceled.", message: nil, preferredStyle: .alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction) in
          self.alert.dismiss(animated: true, completion: nil)
        })
        self.alert.addAction(ok)
        self.present(self.alert, animated: true, completion: nil)
      }
    })
    alert.addAction(cancel)
    indicator = UIActivityIndicatorView(frame:CGRect(x: 140, y:80, width:40, height:40))
    //indicator.center = self.view.center;
    //indicator.hidesWhenStopped = true
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = .black
    indicator.startAnimating();
    //alert.setValue(loadingIndicator, forKey: "accessoryView");
    alert.view.addSubview(indicator)
    present(alert, animated: true, completion: nil)
    
    
    //     let alertnext: UIAlertView = UIAlertView(title: nil, message: "Copy Canceled.", delegate: self, cancelButtonTitle: "OK");
    
    let when = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: when) {
      self.alert.dismiss(animated: true, completion: nil)
    }
    
    
    
    //
    //        let alert = UIAlertController(title: nil, message: "Copying...", preferredStyle: .alert)
    //
    //        alert.addAction(UIAlertAction(title: "Cancel", style:UIAlertActionStyle.cancel, handler: {(action)in alert.dismiss(animated:true, completion:nil)
    //
    ////            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x:95, y:90, width:40, height:40)) as UIActivityIndicatorView
    ////            loadingIndicator.center = self.view.center;
    ////            loadingIndicator.hidesWhenStopped = true
    ////            loadingIndicator.startAnimating();
    ////            alert.setValue(loadingIndicator, forKey: "accessoryView")
    //
    //
    //                    let when = DispatchTime.now() + 3
    //                    DispatchQueue.main.asyncAfter(deadline: when) {
    //                        alert.dismiss(animated: true, completion:nil)
    //                    }
    //
    //
    //            let alertnext = UIAlertController(title: nil, message: "Copy canceled.", preferredStyle: .alert)
    //            alertnext.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.default, handler: {(action)in
    //                alertnext.dismiss(animated:true, completion:nil)
    //            }))
    //            self.present(alertnext, animated:true, completion: nil)
    //        }))
    //
    //            self.present(alert, animated:true, completion: nil)
    //
    
    
    
    
  }
}
