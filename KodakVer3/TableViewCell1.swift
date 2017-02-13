//
//  TableViewCell1.swift
//  KodakVer3
//
//  Created by jmolas on 1/4/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {

  
    @IBOutlet weak var numberOfCopies: UILabel!
    
    @IBOutlet weak var copiesStepper: UIStepper!
    
    @IBOutlet weak var copies: UILabel!
    
    @IBAction func stepper(_ sender: UIStepper) {
        
        
            
        self.numberOfCopies.text = Int(sender.value).description
        
        
    }
}
