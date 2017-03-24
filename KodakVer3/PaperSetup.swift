//
//  PaperSetup.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PaperSetup: UIViewController, PaperSizeProtocol, PaperTypeProtocol{
    
    func setPaperTypeData(dataRow: String) {
        paperTypeButton.titleLabel!.text = dataRow
        UserDefaults.standard.set(dataRow, forKey: "paperType")
    }
    
    func setPaperSizeData(dataRow: String) {
        paperSizeButton.titleLabel?.text = dataRow
        UserDefaults.standard.set(dataRow, forKey: "paperSize")
    }
    
    @IBOutlet weak var paperSizeButton: UIButton!
    @IBOutlet weak var paperTypeButton: UIButton!
    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var descPaperSetup: UILabel!
    @IBOutlet weak var viewPaperSize: UIView!
    @IBOutlet weak var viewPaperType: UIView!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var alrController: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    var paperSizeData: String?
    var paperTypeData: String?
    
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popUpPaperSize"{
            let vc: PopUpPaperSizeVC = segue.destination as! PopUpPaperSizeVC
            vc.delegate = self
        }
        else if segue.identifier == "popUpPaperType"{
            let vc: PopUpPaperTypeVC = segue.destination as! PopUpPaperTypeVC
            vc.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let size: String? = UserDefaults.standard.object(forKey: "paperSize") as? String
        let type: String? = UserDefaults.standard.object(forKey: "paperType") as? String
        
        if let sizeToDisplay = size {
            paperSizeButton.titleLabel?.text = sizeToDisplay
        }
        
        if let typeToDisplay = type {
            paperTypeButton.titleLabel?.text = typeToDisplay
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        // button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        //paperSizeButton.contentHorizontalAlignment = .right
        paperSizeButton.titleEdgeInsets.right = 10
        paperTypeButton.titleEdgeInsets.right = 10
    }
    
    func loadAlerts(){
        
        descPaperSetup.isHidden = true
        viewPaperSize.isHidden = true
        viewPaperType.isHidden = true
        saveSettingButton.isHidden = true
        
            
        alert = UIAlertController(title: "Getting Printer setting...\n\n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 50, height:50))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert(){
        self.alert?.dismiss(animated: true, completion: nil)
        
        descPaperSetup.isHidden = false
        viewPaperSize.isHidden = false
        viewPaperType.isHidden = false
        saveSettingButton.isHidden = false
    }
    
    func setDataFromDisplay(dataSent: String){
        self.paperSizeData = dataSent
        self.paperTypeData = dataSent
    }
    
    @IBAction func saveSettingActionButton(_ sender: UIButton) {
        alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        
        alert.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        
        self.present(alert, animated: true, completion: nil)
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
    }
    
    func dismissAlert_2(){
        self.alert?.dismiss(animated: true, completion: {
            self.alert2 = UIAlertController(title: "", message: "Setting is saved", preferredStyle: .alert)
            self.present(self.alert2, animated: true, completion: {
                //self.alert2?.dismiss(animated: true, completion: nil)
                _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissAlert_3), userInfo: nil, repeats: false)
            })
        })
    }
    
    func dismissAlert_3(){
        self.alert2?.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }    
}
