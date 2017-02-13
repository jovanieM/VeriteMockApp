//
//  QuickDetailSelector.swift
//  KodakVer3
//
//  Created by jmolas on 12/7/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit

class QuickDetailSelector: UIView {
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func layoutSubviews() {
        let quickButton = UIButton()
        quickButton.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 2, height: self.bounds.width / 8)
        quickButton.setTitle("Quick", for: .selected)
        quickButton.addTarget(self, action: #selector(self.handleClick(_:)), for: .touchUpInside)
        addSubview(quickButton)
        
        let detailButton = UIButton()
        detailButton.frame = CGRect(x: quickButton.frame.maxX, y: 0, width: self.bounds.width / 2, height: self.bounds.width / 8)
        detailButton.setTitle("Detail", for: .normal)
        addSubview(detailButton)
        
        
    }
    
    
    func handleClick(_ sender: UIButton) {
        
        if(sender.isSelected){
            print("selected")
        }else{
            print("not")
        }
    }
    
  
    

}
