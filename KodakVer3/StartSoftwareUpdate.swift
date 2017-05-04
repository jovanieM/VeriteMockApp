//
//  StartSoftwareUpdate.swift
//  KodakVer3
//
//  Created by anarte on 04/05/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class StartSoftwareUpdate: UIViewController {
  
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var btnStartUpdate: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    desc.text = "If [Start Update] is touched, the printer is updated and this app is automatically closed.\nPlease DO NOT turn off the printer until the update is completed."
    
    btnStartUpdate.layer.cornerRadius = 20
    btnStartUpdate.layer.borderWidth = 2
    btnStartUpdate.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor

  }
  @IBAction func actionStartUpdate(_ sender: Any) {
    let alert: UIAlertController = UIAlertController(title: "Printer updating...", message: "Press [OK] to close this app. \n Please restart this app after updting\n the printer.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction) in
      exit(0)
    }))
    present(alert, animated: true, completion: nil)
    
  }
}
