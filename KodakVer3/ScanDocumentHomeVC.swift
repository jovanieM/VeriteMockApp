//
//  ScanDocumentHomeVC.swift
//  KodakVer3
//
//  Created by jmolas on 4/3/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ScanDocumentHomeVC: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!

    
    var croppingRect : CGRect?
    var screenWidth: CGFloat = UIScreen.main.bounds.width * 0.7029
    
//    var imageViewMaxHeight: CGFloat{
//        get{
//            return screenWidth * 1.42
//        }
//        
//    }
    
    var convertedImage : [UIImage] = {
        
        let uiImage = UIImage(named: "tulips")
   
        let imageWidth = (uiImage?.size.height)! * 0.7071

        let imageRef = uiImage?.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: imageWidth, height: (uiImage?.size.height)!))
        
        let image = UIImage(cgImage: imageRef!)
        
        let imageRef2 = uiImage?.cgImage?.cropping(to: CGRect(x: (uiImage?.size.width)! / 3, y: 0, width: imageWidth, height: (uiImage?.size.height)!))
        
        let image2 = UIImage(cgImage: imageRef2!)
        
        let imageRef3 = uiImage?.cgImage?.cropping(to: CGRect(x: (uiImage?.size.width)! - imageWidth, y: 0, width: imageWidth, height: (uiImage?.size.height)!))
        
        let image3 = UIImage(cgImage: imageRef3!)
     
        return [image, image2, image3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanSettings.backgroundColor = UIColor.black.withAlphaComponent(0.8)
       
        popUpActivityIndicatorAlert()
       
    }
   
    
    func popUpActivityIndicatorAlert(){
        
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
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.scanningDone), object: nil)
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.displayImage), object: nil)
        }))
        
        
        self.navigationController?.present(alertScanning, animated: true, completion: {
        
        })
        
        self.perform(#selector(self.scanningDone), with: nil, afterDelay: 4)
        self.perform(#selector(displayImage), with: nil, afterDelay: 5)

    
    }
   
    
    func scanningDone(){
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func displayImage(){
        
        scanCounter = scanCounter + 1
        scannedImageID = scanCounter
        scannedItems.text = "\(scannedImageID)/\(scanCounter)"
        imageView.image = convertedImage[(scanCounter - 1) % 3]//convertedImage[0]
        cropIcon.isHidden = false
        cropButton.isEnabled = true
        sendIcon.isHidden = false
        sendButton.isEnabled = true
        imageView.isUserInteractionEnabled = false
        
        touchToScanLabel.isHidden = true
        buttonNext.isEnabled = false
        
        if scanCounter > 1{
            
            buttonPrevious.isEnabled = true
        
        }
        
    }
    
    func cancelingTaskAlert(){
        
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
    func scanCanceled(){
        
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Scan Canceled", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (alert: UIAlertAction) in
            
            if self.scanCounter == 0{
                self.touchToScanLabel.isHidden = false
                self.imageView.isUserInteractionEnabled = true

            }

        }))
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
        updateScanSettingsUI()
    }
    func updateScanSettingsUI(){
        
        let s = ScandocSettingViewController()
        let qualKey = s.defaultColor.integer(forKey: "Quality")
        scanSettings.docScanQuality.text = ScanQuality(rawValue: qualKey)?.description()
        
        let colorKey = s.defaultColor.integer(forKey: "Color")
        scanSettings.docScanColor.text = ScanColor(rawValue: colorKey)?.description()
        
        let docKey = s.defaultColor.integer(forKey: "Document")
        scanSettings.docScanDocument.text = ScanDocumentType(rawValue: docKey)?.description()
        
        let saveAsKey = s.defaultColor.integer(forKey: "Save as type")
        scanSettings.docScanSaveAsType.text = SaveAsType(rawValue: saveAsKey)?.description()
        
    }
  
    // interfaces, buttons and button actions

    @IBOutlet weak var buttonContainer: UIView!

    @IBOutlet weak var scanSettings: ScanSettingsPreview!{
        didSet{
            updateScanSettingsUI()
        }
    }
    
 
    
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBAction func actionNext(_ sender: UIButton) {
     
        scannedImageID += 1
        imageView.image = convertedImage[(scannedImageID - 1) % 3]
        scannedItems.text = "\(scannedImageID)/\(scanCounter)"
        if scannedImageID == scanCounter{
            buttonNext.isEnabled = false
        }
        buttonPrevious.isEnabled = true
    }
    @IBOutlet weak var buttonPrevious: UIButton!
    
    @IBAction func actionPrevious(_ sender: UIButton) {
        scannedImageID -= 1
        imageView.image = convertedImage[(scannedImageID - 1) % 3]
        scannedItems.text = "\(scannedImageID)/\(scanCounter)"
        if scannedImageID < 2{
            buttonPrevious.isEnabled = false
        }
        buttonNext.isEnabled = true
    
    }
    
    @IBAction func touchToScanAction(_ sender: UITapGestureRecognizer) {
        popUpActivityIndicatorAlert()
    }
    
    @IBOutlet weak var scannedItems: UILabel!
    @IBOutlet weak var touchToScanLabel: UILabel!
    @IBOutlet weak var cropIcon: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    
    @IBAction func cropButtonAction(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var sendIcon: UIImageView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        if !sendIcon.isHighlighted{
            openTray()
            
        }else{
            
            closeTray()
        
        }
    
    }
    private func openTray(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonContainer.center.y = self.buttonContainer.center.y - self.buttonContainer.frame.height
            self.buttonNext.isUserInteractionEnabled = false
        }) { (done) in
            if done{
                self.sendIcon.isHighlighted = true
            }
        }

    }
    private func closeTray(){
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonContainer.center.y = self.buttonContainer.center.y + self.buttonContainer.frame.height
            self.buttonNext.isUserInteractionEnabled = true
        }) { (done) in
            if done{
                self.sendIcon.isHighlighted = false
            }
        }
    }
    
    var scanCounter: Int = 0
    var scannedImageID: Int = 0
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        
        if sendIcon.isHighlighted{
            closeTray()
        }
        
        popUpActivityIndicatorAlert()
        
        
    }
    @IBAction func openScanSettings(_ sender: UIButton) {
        print("print")
        let sb = UIStoryboard(name: "ScanSettingsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ScanDocSettingsMenuVC")
        self.show(vc, sender: self)
    }
 
}
