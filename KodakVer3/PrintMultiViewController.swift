//
//  PrintMultiViewController.swift
//  KodakVer3
//
//  Created by jmolas on 3/14/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintMultiViewController: UIViewController {
    
    
    var onDone: (() -> Void)? = nil
    var onPrint: (() -> Void)? = nil
    
    @IBAction func printMulti(_ sender: UIButton) {
        self.onDone!()
        self.onPrint!()
        self.dismiss(animated: false, completion: nil)
        
    }

    @IBAction func cancelView(_ sender: UIButton) {
        self.onDone!()
        self.dismiss(animated: true, completion: nil)
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        // Do any additional setup after loading the view.
    }

}
