//
//  SettingsTableViewCell.swift
//  KodakVer3
//
//  Created by jmolas on 1/19/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var settingName: UILabel!
  

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      
        settingName = UILabel(frame: CGRect(x: self.frame.height / 4, y: 0, width: self.frame.width * 0.75, height: self.frame.height))
        settingName.textAlignment = .left
        self.addSubview(settingName)

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
