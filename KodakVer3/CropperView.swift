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
        setupCornerTrim()
    }
    
    func setupCornerTrim(){
        print("ajaja")

    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tl = UIImageView(image: #imageLiteral(resourceName: "scale_tl"))
        tl.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tl.contentMode = .scaleAspectFill
        self.addSubview(tl)
        
        let ur = UIImageView(image: #imageLiteral(resourceName: "scale_ur"))
        ur.frame = CGRect(x: self.bounds.width - 30, y: 0, width: 30, height: 30)
        ur.contentMode = .scaleAspectFill
        self.addSubview(ur)
        
        let bl = UIImageView(image: #imageLiteral(resourceName: "scale_bl"))
        bl.frame = CGRect(x: 0, y: self.bounds.height - 30, width: 30, height: 30)
        bl.contentMode = .scaleAspectFill
        self.addSubview(bl)
        
        let br = UIImageView(image: #imageLiteral(resourceName: "scale_br"))
        br.frame = CGRect(x: self.bounds.width - 30, y: self.bounds.height - 30, width: 30, height: 30)
        br.contentMode = .scaleAspectFill
        self.addSubview(br)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
