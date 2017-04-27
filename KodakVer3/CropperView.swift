//
//  CropperView.swift
//  KodakVer3
//
//  Created by jmolas on 4/26/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CropperView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCornerTrim()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCornerTrim(){
        let tl = UIImageView(image: #imageLiteral(resourceName: "scale_tl"))
        tl.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tl.contentMode = .scaleAspectFill
        self.addSubview(tl)
        
        
    
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
