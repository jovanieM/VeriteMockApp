//
//  PagesPerSideTableViewCell.swift
//  KodakVer3
//
//  Created by SQA on 02/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PagesPerSideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var persideImages: UIImageView!

    @IBOutlet weak var persideLabels: UILabel!
       
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
 //       persideLabels = UILabel(frame: CGRect(x: self.frame.height / 4, y: 0, width: self.frame.width / 2, height: self.frame.height))
 //       persideLabels.textAlignment = .left
 //       self.addSubview(persideLabels)
 //       self.addSubview(persideImages)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    //   fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.accessoryView = UIImageView(image: #imageLiteral(resourceName: "checkmark_list"))
            
        }
        
        
        
        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        settingName.frame = CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.height * 0.1, width: contentView.frame.width / 2.0, height: contentView.frame.height * 0.8)
        
        
        
    }
    
}
