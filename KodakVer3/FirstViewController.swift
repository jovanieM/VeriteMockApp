//
//  ViewController.swift
//  KodakVer3
//
//  Created by jmolas on 12/7/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit

extension CATransition{
    
    static func popAnimationDisabler() -> CATransition{
        
        let navTransition = CATransition()
        navTransition.duration = 0.4
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        return navTransition
    
    }

}

class FirstViewController: UIViewController, PrinterSelectDelegate{
    
    
    
    @IBOutlet weak var ecomodeLabel: UILabel!
    
    @IBOutlet weak var ecoLed1: UIImageView!
    
    @IBOutlet weak var ecoLed2: UIImageView!
     
    @IBOutlet weak var addPrinter: UIButton!
    
    @IBOutlet weak var checkmark: UIImageView!
    
    @IBOutlet weak var selectedPrinter: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
//    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var name: UILabel!
    var previousPrinter: Int = 0

    var printer: String? = "KODAK VERITE 55 PLUS"
    let listOfPrinters : [String] = ["Kodak 1", "Kodak 2", "Kodak 3", "Kodak 4", "Kodak 5", "Kodak 6", "Kodak 7"]
    var printers : PrinterSelectPopUp!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = printer
        name.layer.borderColor = UIColor.black.cgColor
        selectedPrinter.text = "Selected printer"
        checkmark.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    
    @IBAction func openSettingScene(_ sender: UIBarButtonItem) {
        let settingSB = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        let vc = settingSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    
    @IBAction func selectPrinter(_ sender: Any) {
        
        
        if(selectedPrinter.text == "Searching for printer"){
            
            let alertController = UIAlertController(title: nil, message: "Start setup for new printer. Please turn off the power of other printers. After turning off, touch [OK]. Easy Setup is started.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                UIAlertAction in
    //            self.InsteadOfEasySetup()
                self.viewDidLoad()
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        } else {
    
     
            printers = PrinterSelectPopUp(frame: CGRect(x: UIScreen.main.bounds.minX, y:UIScreen.main.bounds.minY, width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY))
            
            printers.printerList = listOfPrinters
            printers.currentPrinter = previousPrinter
            self.view.window?.addSubview(printers)
            
            
            printers.delegate = self
        }
    
    }

    func select(index: Int) {
        name.text = listOfPrinters[index]
        //button.setTitle(listOfPrinters[index], for: .normal)
        previousPrinter = index
    }
    
    @IBAction func Copy(_ sender: Any) {
        let CopySB = UIStoryboard(name: "CopyStoryboard", bundle: nil)
        let vc = CopySB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    @IBAction func InkLevel(_ sender: Any) {
        let InkLevelSB = UIStoryboard(name: "InkLevelStoryboard", bundle: nil)
        let vc = InkLevelSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
//    @IBAction func ScanDoc(_ sender: Any) {
//        let ScanDocSB = UIStoryboard(name: "ScanDocumentStoryboard", bundle: nil)
//        let vc = ScanDocSB.instantiateInitialViewController()!
//        self.show(vc, sender: self)
//    }
    
    @IBAction func AddressPrint(_ sender: Any) {
    
        let AddressPrintSB = UIStoryboard(name: "AddressPrintStoryboard", bundle: nil)
        let vc = AddressPrintSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }

//    @IBAction func ScanPhoto(_ sender: Any) {
//        let ScanPhotoSB = UIStoryboard(name: "ScanPhotoStoryboard", bundle: nil)
//        let vc = ScanPhotoSB.instantiateInitialViewController()!
//        self.show(vc, sender: self)
//    }
    
    @IBAction func Print(_ sender: Any) {
        let PrintSB = UIStoryboard(name: "PrintPhotoStoryboard", bundle: nil)
        let vc = PrintSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    @IBAction func ecomodebuttonPressed(_ sender: Any) {
        
        ConfirmingMessage()
        
    
        if ecoLed1.image == UIImage(named: "ecoled_off") && ecoLed2.image == UIImage(named: "ecoled_off"){
            
            ecomodeLabel.text = "Eco Mode 1"
            ecoLed2.image = UIImage(named: "ecoled_on")
            ecoLed1.image = UIImage(named: "ecoled_off")
        }
        else if ecoLed2.image == UIImage(named: "ecoled_on") && ecoLed1.image == UIImage(named: "ecoled_off"){
            ecomodeLabel.text = "Eco Mode 2"
            ecoLed1.image = UIImage(named: "ecoled_on")
            ecoLed2.image = UIImage(named: "ecoled_on")
            
        }else{
            ecomodeLabel.text = "Eco Mode Off"
            ecoLed1.image = UIImage(named: "ecoled_off")
            ecoLed2.image = UIImage(named: "ecoled_off")
        }
    }

    
    @IBAction func AddPrinter(_ sender: Any) {
        
        checkmark.isHidden = true
 //       self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        name.text = "Add new printer"
        selectedPrinter.text = "Searching for printer"
        name.layer.borderWidth = 1.0
       
        name.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        activityIndicator.hidesWhenStopped = true
        
//        let alertController = UIAlertController(title: "Test", message: "test2", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        
//        let OKAction = UIAlertAction(title: "OK", style: .default) {
//            UIAlertAction in
//            self.viewDidLoad()
//            self.PrinterSelection()
//        }
//        alertController.addAction(OKAction)
//        self.present(alertController, animated: true, completion: nil)
//        
//        
//        let when = DispatchTime.now() + 4.0
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            self.activityIndicator.stopAnimating()
//        }
        
       
    
    }

    
//    func InsteadOfEasySetup(){
//        self.activityIndicator.stopAnimating()
//        self.name.text = "KODAK VERITE 65 PLUS"
//        self.selectedPrinter.text = "Selected Printer"
//        self.checkmark.isHidden = false
//        
//        
//    }
//    
    
    
    
    func ConfirmingMessage (){
        
        let alert: UIAlertView = UIAlertView(title: nil, message: "Confirming...", delegate: self, cancelButtonTitle: nil);
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
        }
    }

}



