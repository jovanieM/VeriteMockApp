//
//  ScanDocumentHomeVC.swift
//  KodakVer3
//
//  Created by jmolas on 4/3/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices
import WebKit


class ScanDocumentHomeVC: UIViewController, UIDocumentInteractionControllerDelegate, SaveAsViewDelegate, MFMailComposeViewControllerDelegate, CropViewDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageDictionary = [Int: UIImage?]()
    var saveToDictionary : Bool = false
    
    var croppingRect : CGRect?
    var screenWidth: CGFloat = UIScreen.main.bounds.width * 0.7029
    
    @IBOutlet weak var scannedItems: UILabel!
    @IBOutlet weak var touchToScanLabel: UILabel!
    @IBOutlet weak var cropIcon: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    
    var convertedImage : [UIImage?] = {
        
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
        runScanner()
        //popUpActivityIndicatorAlert()
        definesPresentationContext = true
        
    }
    
    func runScanner(){
        self.imageView.isUserInteractionEnabled = false
        WorkProgressSimulator.sharedInstance.popUpActivityIndicatorAlert(controller: self.navigationController!) { (completed) in
            
            if completed{
                self.displayImage()
            }else{
                if self.scanCounter == 0{
                    self.touchToScanLabel.isHidden = false
                    self.imageView.isUserInteractionEnabled = true
                    
                }
            }
            
        }
        
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
        imageView.isUserInteractionEnabled = true
        
        touchToScanLabel.isHidden = true
        buttonNext.isEnabled = false
        
        if scanCounter > 1{
            
            buttonPrevious.isEnabled = true
            
        }
        
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
        ext = SaveAsType(rawValue: saveAsKey)?.extensionType()
        
        
    }
    
    // interfaces, buttons and button actions
    
    var isTrayOpen: Bool = false
    var scanCounter: Int = 0
    var scannedImageID: Int = 0
    var ext : String?
    
    @IBOutlet weak var buttonContainer: UIView!
    
    @IBOutlet weak var scanSettings: ScanSettingsPreview!{
        didSet{
            updateScanSettingsUI()
            
        }
    }
    
    
    
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBAction func actionNext(_ sender: UIButton) {
        
        
        scannedImageID += 1
        if let im = imageDictionary[scannedImageID]{
            imageView.image = im
            
        }else{
            imageView.image =  convertedImage[(scannedImageID - 1) % 3]
            
        }
        
        scannedItems.text = "\(scannedImageID)/\(scanCounter)"
        if scannedImageID == scanCounter{
            buttonNext.isEnabled = false
        }
        buttonPrevious.isEnabled = true
    }
    
    @IBOutlet weak var buttonPrevious: UIButton!
    
    @IBAction func actionPrevious(_ sender: UIButton) {
        
        
        scannedImageID -= 1
        if let im = imageDictionary[scannedImageID]{
            imageView.image = im
            
        }else{
            imageView.image =  convertedImage[(scannedImageID - 1) % 3]
            
        }
        scannedItems.text = "\(scannedImageID)/\(scanCounter)"
        if scannedImageID < 2{
            buttonPrevious.isEnabled = false
        }
        buttonNext.isEnabled = true
        
    }
    
    
    @IBAction func touchToScan(_ sender: UITapGestureRecognizer) {
        
        print("tapped")
        if imageView.image == nil{
            runScanner()
        }else{
            
            if isTrayOpen{
                
                openCloseTray(open: isTrayOpen)
            }
        }
    }
    
    
    // send func temp button
    var documentController : UIDocumentInteractionController!
    
    @IBAction func cropButtonAction(_ sender: UIButton) {
        if isTrayOpen { openCloseTray(open: isTrayOpen) }
        
        let cropImageSB = UIStoryboard(name: "CropViewStoryboard", bundle: nil)
        if let vc = cropImageSB.instantiateInitialViewController() as? CropViewController{
            vc.delegate = self
            vc.image = imageView.image
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    
    
    @IBOutlet weak var sendIcon: UIImageView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        
        openCloseTray(open: isTrayOpen)
        
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        
        if isTrayOpen{
            
            openCloseTray(open: isTrayOpen)
        }
        runScanner()
        // popUpActivityIndicatorAlert()
    }
    
    @IBAction func googleDrive(_ sender: UIButton) {
        if #available(iOS 9.0, *) {
            
            let url = URL(string: "https://accounts.google.com")
            let sfVC = SFSafariViewController(url: url!)
            
            
            self.present(sfVC, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    @IBAction func email(_ sender: UIButton) {
        
        let action = ButtonActions(viewController: self)
        
        // let act = ButtonActions()
        
        //let url = createLocalURL(forImageNamed: fname, forUIImage: imageView.image!, ext: ext!)
        
        if let mail = action.configuredMailComposerVC(image: imageView.image!, mimeSubtype : "jpeg"){
            mail.mailComposeDelegate = self
            if MFMailComposeViewController.canSendMail(){
                
                self.present(mail, animated: true, completion: nil)
                
            }else{
                print("unable to send mail")
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
    
    @IBAction func openScanSettings(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "ScanSettingsStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ScanDocSettingsMenuVC")
        self.show(vc, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editFileName"{
            let vc = segue.destination as! SaveAsVCViewController
            vc.delegate = self
            if scanSettings.docScanSaveAsType.text == SaveAsType.Pdf.description(){
                vc.extName = "pdf"
            }else{
                vc.extName = "jpg"
            }
        }
        if segue.identifier == "box"{
            let navC = segue.destination as! UINavigationController
            let child = navC.viewControllers.first as! BoxUIWebViewController
            child.urlString = "https://account.box.com"
        }
        if segue.identifier == "oneDrive"{
            let navC = segue.destination as! UINavigationController
            let child = navC.viewControllers.first as! BoxUIWebViewController
            child.urlString = "https://login.live.com"
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "editFileName"{
            if scanSettings.docScanSaveAsType.text == SaveAsType.Jpeg.description(){
                UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(saveToCameraRoll), nil)
                
                let alertScanning = UIAlertController(title: "Saving...", message: "\n\n", preferredStyle: .alert)
                
                
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                activityIndicator.color = .gray
                
                activityIndicator.frame = alertScanning.view.bounds
                activityIndicator.center.y = alertScanning.view.center.y + 8.0
                activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
                alertScanning.view.addSubview(activityIndicator)
                
                activityIndicator.isUserInteractionEnabled = false
                
                activityIndicator.startAnimating()
                self.navigationController?.present(alertScanning, animated: true, completion: nil)
                
                
                return false
            }
            
        }
        if identifier == "box"{
            return true
        }
        return true
    }
    
    func dismissSaveToCam(){
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func saveToCameraRoll(image : UIImage, didFinishSavingWithError error : NSError?, contextInfo: UnsafeRawPointer){
        guard error == nil else {
            
            return
        }
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: {
            let alertScanning = UIAlertController(title: "Saved to camera roll", message: nil, preferredStyle: .alert)
            
            
            alertScanning.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                NSObject.cancelPreviousPerformRequests(withTarget: self)
            }))
            self.navigationController?.present(alertScanning, animated: true, completion: nil)
            
        })
        
        self.perform(#selector(dismissSaveToCam), with: self, afterDelay: 2.0)
    }
    
    func saveImage(name : String, ext : String){
        
        save(filename: name, fileExt : ext)
    }
    
    
    
    func finishWithError(){
        print("error authorization")
        
    }
    func getImageFromCrop(image: UIImage?) {
        if let im = image{
            saveToDictionary = true
            imageDictionary[scannedImageID] = im
            imageView.image = im
        }
        
        
    }
    
    
    
}
