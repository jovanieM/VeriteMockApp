//
//  DirectConnectTime.swift
//  KodakVer3
//
//  Created by anarte on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class DirectConnectTime: UIViewController, DirectConnectTimeProtocol{

    @IBOutlet weak var saveSettingButton: UIButton!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var viewDirectConnect: UIView!
    
    var alert: UIAlertController!
    var alert2: UIAlertController!
    var indicator: UIActivityIndicatorView!
    @IBOutlet weak var directTimeLabel: UIButton!
    var directConnectTimeData: String?
    
    @IBOutlet weak var directLabel: UILabel!
    
    
    
    func setTableRowData(dataRow: String) {
        //directTimeLabel.titleLabel?.text = dataRow
        //let vc: PopUpDirectConnectTime = PopUpDirectConnectTime()
        
        //directLabel.text = vc.data
        directLabel.text = dataRow
        
        //directConnectTimeData = dataRow
    }
    
    //navigation bar
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
        
        loadAlerts()
        
        //let vc: PopUpDirectConnectTime = PopUpDirectConnectTime()
        directLabel.text = directConnectTimeData
        
        //button
        saveSettingButton.layer.cornerRadius = 15
        saveSettingButton.layer.borderWidth = 2
        saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    }
    
    func loadAlerts(){
        desc.isHidden = true
        viewDirectConnect.isHidden = true
        saveSettingButton.isHidden = true
        
        alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }))
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 40, height:40))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
                
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        self.present(alert, animated: true, completion: nil)
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }
    
    func dismissAlert(){
        alert.dismiss(animated: true, completion: nil)
        
        desc.isHidden = false
        viewDirectConnect.isHidden = false
        saveSettingButton.isHidden = false
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popUpDirectConnect"{
            let vc: PopUpDirectConnectTime = segue.destination as! PopUpDirectConnectTime
            vc.delegate = self
        }
    }
    
    func setDataFromDisplay(dataSent: String){
        self.directConnectTimeData = dataSent
    }
    
    
}
