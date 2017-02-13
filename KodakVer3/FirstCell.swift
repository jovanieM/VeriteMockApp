//
//  FirstCell.swift
//  KodakVer3
//
//  Created by jmolas on 1/23/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {
    
    var label: UILabel!
    var numberOfCopies: UILabel!
    
    var copySetter: UIStepper!
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){
        
        self.backgroundColor = .black
       
        label = UILabel()
        label.text = "Copies :"
        label.textColor = .lightGray
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        // left constraint
        addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8))
        // width constraint
        addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0))
        // height constraint
        addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        
        numberOfCopies = UILabel()
        numberOfCopies.backgroundColor = .white
        numberOfCopies.textAlignment = .right
        numberOfCopies.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(numberOfCopies)
        
        // centerX constraint
        addConstraint(NSLayoutConstraint(item: numberOfCopies, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.95, constant: 0))
        // width constraint
        addConstraint(NSLayoutConstraint(item: numberOfCopies, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        // height constraint
        addConstraint(NSLayoutConstraint(item: numberOfCopies, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.7, constant: 0))
        addConstraint(NSLayoutConstraint(item: numberOfCopies, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        
        copySetter = UIStepper()
        copySetter.tintColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
        copySetter.value = 1
        copySetter.minimumValue = 1
        copySetter.maximumValue = 99
        copySetter.isContinuous = true
        copySetter.translatesAutoresizingMaskIntoConstraints = false
        copySetter.addTarget(self, action: #selector(handleIncDec(_ :)), for: .valueChanged)
        copySetter.autorepeat = true
        self.addSubview(copySetter)
        
      
        
    
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
//        label.frame = CGRect(x: 0, y: 0, width:  self.frame.width * 0.33, height: self.frame.height * 0.4)
//        label.center = CGPoint(x: label.frame.midX , y: self.bounds.midY)
        
        
//        numberOfCopies.frame = CGRect(x: 0, y: 0, width: self.frame.height * 0.83 , height: self.frame.height * 0.67)
//        numberOfCopies.center = CGPoint(x: self.frame.width * 0.45, y: self.frame.midY)
        
        // right constraint
        addConstraint(NSLayoutConstraint(item: copySetter, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .right , multiplier: 0.8, constant: 0))
        // width constraint
        addConstraint(NSLayoutConstraint(item: copySetter, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        // height constraint
        addConstraint(NSLayoutConstraint(item: copySetter, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.4, constant: 0))
        addConstraint(NSLayoutConstraint(item: copySetter, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))

//        copySetter.frame = CGRect(x: 0, y: 0, width: self.bounds.width * 0.2, height: self.bounds.height * 0.4)
//        copySetter.center = CGPoint(x: self.frame.width * 0.76, y: self.bounds.midY)
        
        
    }
    
    func handleIncDec(_ sender: UIStepper){
        numberOfCopies.text = Int(sender.value).description
    }
    
    
}
