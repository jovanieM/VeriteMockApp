//
//  BrightnessTableViewCell.swift
//  KodakVer3
//
//  Created by SQA on 01/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class BrightnessTableViewCell: UITableViewCell {

    @IBOutlet weak var brightness: UILabel!
        
    @IBOutlet weak var brightnessbar: UISlider!
    
    @IBAction func cheangeTip(_ sender: UISlider) {
        brightnessbar.value = roundf(brightnessbar.value)
    }
    
}
