//
//  CustomCopySecondCell.swift
//  KodakVer3
//
//  Created by SQA on 23/02/2017.
//  Copyright © 2017 mmolo. All rights reserved.
//

import UIKit

class CustomCopySecondCell: UITableViewCell {

    
    @IBOutlet weak var settingname: UILabel!
    
    @IBOutlet weak var selectedsetting: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingname.text = nil
        selectedsetting.text = nil
    }
    
    
}
