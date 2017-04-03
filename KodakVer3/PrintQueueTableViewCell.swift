//
//  PrintQueueTableViewCell.swift
//  KodakVer3
//
//  Created by jmolas on 3/27/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol ButtonCellDelegate {
    func buttonTapped(cell : PrintQueueTableViewCell)
}


class PrintQueueTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageThumbNail: UIImageView!
    
    @IBOutlet weak var dateNTime: UILabel!
    
    @IBOutlet weak var statusNPages: UILabel!
        @IBOutlet weak var progressView: UIProgressView!
   
    @IBOutlet weak var customAccessory: UIView!
      
    var buttonDelegate : ButtonCellDelegate?

    @IBAction func tapped(_ sender: Any) {
        buttonDelegate?.buttonTapped(cell: self)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //let i = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        // Initialization code
        
    }
 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
