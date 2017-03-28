//
//  PrintQueueTableViewCell.swift
//  KodakVer3
//
//  Created by jmolas on 3/27/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintQueueTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageThumbNail: UIImageView!
    
    @IBOutlet weak var dateNTime: UILabel!
    
    @IBOutlet weak var statusNPages: UILabel!

    @IBOutlet weak var progressView: UIProgressView!
    
    

   
    @IBOutlet weak var buttonId: UIButton!
    
    var pq = PrintQueueViewController()
    
    @IBAction func cancel(_ sender: UIButton) {
        
//        if let index = Int(sender.currentTitle!){
//            let p = PrintQueueViewController()
//            p.printData.remove(at: index)
//          
//        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
