//
//  ViewController.swift
//  KodakVer3
//
//  Created by jmolas on 12/7/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, PrinterSelectDelegate{
    
    
    @IBAction func openSettingScene(_ sender: UIBarButtonItem) {
        let settingSB = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        let vc = settingSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet weak var name: UILabel!
    var previousPrinter: Int = 0

    var printer: String? = "KODAK VERITE 65 PLUS"
    let listOfPrinters : [String] = ["Kodak 1", "Kodak 2", "Kodak 3", "Kodak 4", "Kodak 5", "Kodak 6", "Kodak 7"]
    var printers : PrinterSelectPopUp!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       name.text = printer
        
    
        //        let barTitleImage:UIImageView = {
//            let image = UIImage(named: "apptop")
//            let title  = UIImageView()
//            title.frame = CGRect(x: 0, y: 0, width: 80, height: (self.navigationController?.navigationBar.frame.height)!)
//            title.contentMode = .scaleAspectFit
//            title.image = image
//            return title
//            
//        }()
//        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
//        self.navigationController?.navigationBar.barStyle = .blackOpaque
//        
//        
//        
//        navigationItem.titleView = barTitleImage
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    @IBAction func selectPrinter(_ sender: Any) {
        
        printers = PrinterSelectPopUp(frame: CGRect(x: UIScreen.main.bounds.minX, y:UIScreen.main.bounds.minY, width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY))
        
        printers.printerList = listOfPrinters
        printers.currentPrinter = previousPrinter
        self.view.window?.addSubview(printers)
        
        
        printers.delegate = self
        
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
    
    @IBAction func ScanDoc(_ sender: Any) {
        let ScanDocSB = UIStoryboard(name: "ScanDocumentStoryboard", bundle: nil)
        let vc = ScanDocSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    @IBAction func AddressPrint(_ sender: Any) {
        let AddressPrintSB = UIStoryboard(name: "AddressPrintStoryboard", bundle: nil)
        let vc = AddressPrintSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }

    @IBAction func ScanPhoto(_ sender: Any) {
        let ScanPhotoSB = UIStoryboard(name: "ScanPhotoStoryboard", bundle: nil)
        let vc = ScanPhotoSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    @IBAction func Print(_ sender: Any) {
        let PrintSB = UIStoryboard(name: "PrintPhotoStoryboard", bundle: nil)
        let vc = PrintSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    

}

