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
    var checkMark: UIImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .green
//        settingName = UILabel(frame: .zero)
//     
//        contentView.addSubview(settingName)
//        
//        
        settingName = UILabel(frame: CGRect(x: self.frame.height / 4, y: 0, width: self.frame.width / 2, height: self.frame.height))
        settingName.textAlignment = .left
        self.addSubview(settingName)
        checkMark = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - contentView.frame.height * 1.5, y: 0, width: self.frame.height, height: self.frame.height))
        checkMark.contentMode = .scaleAspectFit
        
        print(contentView.frame.width)
        print(UIScreen.main.bounds.width)
        self.addSubview(checkMark)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            
            checkMark.image = UIImage(named: "checkmark_list")
            //checkMark.image = UIImage(named: "checkmark_list")
        }
        
     
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        settingName.frame = CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.height * 0.1, width: contentView.frame.width / 2.0, height: contentView.frame.height * 0.8)
        
        
        
    }
    


}
