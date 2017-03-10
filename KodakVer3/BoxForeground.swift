//
//  BoxForeground.swift
//  KodakVer3
//
//  Created by jmolas on 2/26/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit


class BoxForeground: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var fillColor : UIColor = UIColor(red: 50/255, green: 50/255, blue:50/255, alpha: 1.0)
    var tranparentHoleView : UIView!
    var sizeHelper : SizeHelper!
    var portrait : Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("coder_Fore \(bounds)")
        
        
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake \(bounds)")
    
    }
    

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
   
        let helper = SizeHelper(frame: rect, orientation: portrait)
        
        let outerBorderPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width:  bounds.width, height: bounds.height))
        let black = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.75)
        black.setFill()
        outerBorderPath.fill()
        
        let thinBorderPath = UIBezierPath(rect: CGRect(origin: helper.origin, size: helper.size))
        thinBorderPath.lineWidth = 2.0
        let gray = UIColor.lightGray
        gray.setStroke()
        thinBorderPath.stroke()
        
        let holeRectPath = UIBezierPath(rect: CGRect(origin: helper.origin, size: helper.size))
        holeRectPath.lineWidth = 8.0
        
        //fillColor.setStroke()
        
        holeRectPath.fill(with: .clear, alpha: 1.0)
        print("fore Draw")
     
        
//        
//        let layer = CAShapeLayer()
//        let path = CGMutablePath()
//        path.addRect(rect2)
//        path.addRect(bounds)
//        
//        layer.path = path
//        layer.fillRule = kCAFillRuleEvenOdd
//        self.layer.mask = layer
        
        
    }
 

}
