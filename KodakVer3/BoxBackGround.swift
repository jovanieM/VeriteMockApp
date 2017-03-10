//
//  BoxBackGround.swift
//  KodakVer3
//
//  Created by jmolas on 2/28/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit


class BoxBackGround: UIView {
    
    var fillColor : UIColor = UIColor.lightGray
    var portrait : Bool = false
    var origin: CGPoint!
    var size: CGSize!
    
//    var imageWidthRelToDevice : CGFloat =
//    let aspect : CGFloat = 0.92
//    var imageHeightRelToDevice : CGFloat!
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init inside boxBG")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("nsCoder inside bxBG")
    
              
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        print("draw_boxBG")
        
        //self.backgroundColor?.setFill()
        let helper = SizeHelper(frame: rect, orientation: portrait)
        
        let pathB = UIBezierPath(rect: CGRect(origin: helper.origin, size: helper.size))
        //pathB.lineWidth = 8.0
        
        //fillColor.setStroke()
        let color = UIColor.white
        color.setFill()
        pathB.fill()

        

    }
    
    
}
