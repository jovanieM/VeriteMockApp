//
//  ItemsTableViewCell.swift
//  KodakVer3
//
//  Created by SQA on 10/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemCell: UILabel!
    
    @IBOutlet weak var checkmark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        if selected{
//            
//            self.contentView.backgroundColor = UIColor.clear
//            self.accessoryView = UIImageView(image: #imageLiteral(resourceName: "checkmark_list"))
//        }
//    }
    
}
