//
//  SaveSetting.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PaperSetup: UIViewController, MyProtocol{

    
    @IBOutlet weak var paperSizeButton: UIButton!
    @IBOutlet weak var saveSettingButton: UIButton!
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var alrController: UIAlertController!
    var indicator: UIActivityIndicatorView!
    
    var paperSizeData: String?
    
    
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    func setTableRowData(dataRow: String) {
        paperSizeButton.titleLabel?.text = dataRow
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popUpPaperSize"{
            let vc: PopUpPaperSizeVC = segue.destination as! PopUpPaperSizeVC
            vc.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlerts()
        
        paperSizeButton.setTitle("Letter               ", for: .normal)
        
        
        // button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        //paperSizeButton.contentHorizontalAlignment = .right
        paperSizeButton.titleEdgeInsets.right = 10
        
        
    }
    
    func loadAlerts(){
        
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
    }
    
    func setDataFromDisplay(dataSent: String){
        self.paperSizeData = dataSent
    }
    
   
    
}
