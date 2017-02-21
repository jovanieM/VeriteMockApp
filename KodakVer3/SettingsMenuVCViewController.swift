//
//  SettingsMenuVCViewController.swift
//  KodakVer3
//
//  Created by jmolas on 12/7/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit

class SettingsMenuVCViewController: UIViewController {

    // to photo print settings storyboard
    @IBAction func openPhotoPrintSB(_ sender: UIButton) {
        let settingSB = UIStoryboard(name: "PhotoPrintSettingsStoryboard", bundle: nil)
        let vc = settingSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
    }
    
    // to scan settings storyboard
    /* @IBAction func toScanSettings(_ sender: UIButton) {
        let scanSettingsSB = UIStoryboard(name: "ScanSettingsStoryboard", bundle: nil)
        let scanSettingsVC = scanSettingsSB.instantiateInitialViewController()!
        self.show(scanSettingsVC, sender: self)
    }*/
    
    @IBAction func toDeviceSettings(_ sender: UIButton) {
        let deviceSettingsSB = UIStoryboard(name: "DeviceSettingsStoryboard", bundle: nil)
        let deviceSettingVC = deviceSettingsSB.instantiateInitialViewController()!
        self.show(deviceSettingVC, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // let back = UIBarButtonItem(title: "<back", style: .plain, target: self, action: #selector(self.popVC))
        // self.navigationItem.leftBarButtonItem = back

        // Do any additional setup after loading the view.
    }
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
