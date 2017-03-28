//
//  PrintMultiViewController.swift
//  KodakVer3
//
//  Created by jmolas on 3/14/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintMultiViewController: UIViewController {
    
    var settings : [SettingsObject] = {
        
        var size = SettingsObject()
        size.paperSize = size.sizes[PrintPhotoVC().getSavedData(receiver: 1)!]
        
        var type = SettingsObject()
        type.paperType = type.types[PrintPhotoVC().getSavedData(receiver: 3)!]
        
        var qual = SettingsObject()
        qual.printQuality = qual.quality[PrintPhotoVC().getSavedData(receiver: 4)!]
        return [size, type, qual]
        
    }()
    
    @IBAction func openPrintSettings(_ sender: UIButton) {
        
        self.onSettings!()
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBOutlet weak var printSettingsPreview: PrintSettingsPreview!{
        didSet{
           updateUI()
        }
    }
    private func updateUI(){
        
        printSettingsPreview.size = settings[0]
        printSettingsPreview.type = settings[1]
        printSettingsPreview.quality = settings[2]
       
        
    }
    var onDone: (() -> Void)? = nil
    var onPrint: (() -> Void)? = nil
    var onSettings: (() -> Void)? = nil
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI()
    }

}
