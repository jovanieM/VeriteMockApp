//
//  CustomCollectionViewCell.swift
//  KodakVer3
//
//  Created by jmolas on 3/9/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        label = UILabel(frame: CGRect(x: self.contentView.frame.maxX - 10, y: self.contentView.frame.minY, width: 10, height: 10))
        label.font = label.font.withSize(8.0)
        label.backgroundColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
        label.alpha = 0.0
        label.textColor = .black
                label.textAlignment = .center
        self.contentView.addSubview(label)
    }
    
    
    override var isSelected: Bool{
        willSet{
            print("any")
            if (newValue){
                self.layer.borderWidth = 2.0
                self.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0).cgColor
                label.alpha = 1.0

                
            }else {
                self.layer.borderColor = UIColor.clear.cgColor
                label.alpha = 0.0
                self.contentView.setNeedsDisplay()
               
            }
            
            
        }
    }
    
}
