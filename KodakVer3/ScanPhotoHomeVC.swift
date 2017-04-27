//
//  ScanPhotoHomeVC.swift
//  KodakVer3
//
//  Created by jmolas on 4/24/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class ScanPhotoHomeVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    // variable declerations --------------------------------------------------------------------------------------------
    var firstScan : Bool = true
    var isTrayOpen : Bool = false

    @IBOutlet weak var cropPhoto: UIButton!
    @IBOutlet weak var sendPhoto: UIButton!
    @IBOutlet weak var cropIcon: UIImageView!
    @IBOutlet weak var sendIcon: UIImageView!
    @IBOutlet weak var scanImage: UIImageView!
    @IBOutlet weak var scanPhotoSettings: ScanPhotoSettingPreview!{
        
        didSet{
            updateScanSettingsUI()
        }
    }
    @IBOutlet weak var buttonContainer: UIView!
    
    @IBOutlet weak var touchToScan: UILabel!
    @IBOutlet weak var sendBTn: UIButton!
    
    // scan, crop and send button actions ---------------------------------------------------------------------------------
    @IBAction func scanPhoto(_ sender: UIButton) {
        if isTrayOpen{
            
            openCloseTray(open: isTrayOpen)
        }
        runScanner()
        
    }
    
    @IBAction func cropPhotoAction(_ sender: UIButton) {
        print("cropPhoto")
    }
    
    @IBAction func sendPhotoAction(_ sender: UIButton) {
        openCloseTray(open: isTrayOpen)
    }
    @IBAction func touchToScanPhoto(_ sender: UITapGestureRecognizer) {
        runScanner()
    }
    @IBAction func sendOptions(_ sender: UIButton){
        
        let action = ButtonActions(viewController: self)
        
        switch sender.tag {
        case 1:
            print()
            let vc = BoxUIWebViewController()
            vc.urlString = "https://login.live.com"
            let nav = UINavigationController(rootViewController: vc)
            
            self.present(nav, animated: true, completion: nil)
        case 2:
            
            let vc = BoxUIWebViewController()
            vc.urlString = "https://account.box.com"
            let nav = UINavigationController(rootViewController: vc)
            
            self.present(nav, animated: true, completion: nil)
        case 3:
            
            if #available(iOS 9.0, *) {
                
                let url = URL(string: "https://accounts.google.com")
                let sfVC = SFSafariViewController(url: url!)
                
                
                self.present(sfVC, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }

  
        case 4:
            

            if let mail = action.configuredMailComposerVC(image: scanImage.image!, mimeSubtype : "jpeg"){
                mail.mailComposeDelegate = self
                if MFMailComposeViewController.canSendMail(){
                    
                    self.present(mail, animated: true, completion: nil)
                    
                }else{
                    print("unable to send mail")
                }
            }
        case 5:
            action.saveToCameraRoll(image: scanImage.image!)
        default:
            return
        }
    
    }
    
    @IBAction func openScanPhotoSettings(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "ScanSettingsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ScanPhotoSettingsMenuVC")
        self.show(vc, sender: self)
    }
    
    
    // viewcontroller lifecycle ---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanPhotoSettings.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        runScanner()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        updateScanSettingsUI()
    }
    
    // declared functions ----------------------------------------------------------------------------
  
    func runScanner(){
        WorkProgressSimulator.sharedInstance.popUpActivityIndicatorAlert(controller: self.navigationController!) { (completed) in
         
            self.enabler(enabled: completed)
       
        }

    }
    
    func enabler(enabled : Bool){
        
        if scanImage.image == nil && enabled{
            
            touchToScan.isHidden = enabled
            scanImage.image = #imageLiteral(resourceName: "tulips")
            cropPhoto.isEnabled = enabled
            sendIcon.isHidden = !enabled
            sendPhoto.isEnabled = enabled
            cropIcon.isHidden = !enabled
            if scanImage.isUserInteractionEnabled{
                scanImage.isUserInteractionEnabled = false
            }
            
        }else{
            
            if scanImage.image == nil{
                touchToScan.isHidden = enabled
                scanImage.isUserInteractionEnabled = true
            }
            
        }
        
    }
    
    func updateScanSettingsUI(){
        
        let scanP = ScanPhotoSettingViewController()
        let quality = scanP.defaultQualityPhoto.integer(forKey: "QualityPhoto")
        scanPhotoSettings.scanPhotoQuality.text = ScanPhotoQuality(rawValue: quality)?.description()
        
        let color = scanP.defaultColorPhoto.integer(forKey: "ColorPhoto")
        scanPhotoSettings.scanPhotoColor.text = ScanPhotoColor(rawValue: color)?.description()
 
    }
    
    func openCloseTray(open : Bool){
        
        if open{
            // tray is currently open
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonContainer.center.y = self.buttonContainer.center.y + self.buttonContainer.frame.height
                
                self.isTrayOpen = false
            }) { (done) in
                if done{
                    self.sendIcon.isHighlighted = false
                }
            }
            
        }else{
            // tray is currently close
            
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonContainer.center.y = self.buttonContainer.center.y - self.buttonContainer.frame.height
                self.isTrayOpen = true
            }) { (done) in
                if done{
                    self.sendIcon.isHighlighted = true
                }
            }
            
        }
    }
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .sent:
            print("message is sent")
            controller.dismiss(animated: true, completion: nil)
        case .saved:
            print("message is saved")
            controller.dismiss(animated: true, completion: nil)
        case .cancelled:
            print("message is cancelled")
            controller.dismiss(animated: true, completion: nil)
        case .failed:
            print("message is failed")
            controller.dismiss(animated: true, completion: nil)
        }
    }
    




}
