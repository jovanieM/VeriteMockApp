//
//  HeaderTableViewCell.swift
//  KodakVer3
//
//  Created by SQA on 10/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    @IBOutlet weak var down_allow: UIImageView!
    
    @IBOutlet weak var headerCellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
