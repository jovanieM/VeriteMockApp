//
//  CropperView.swift
//  KodakVer3
//
//  Created by jmolas on 4/26/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CropperView: UIView {
    
    
    // var path : UIBezierPath!
    var tl: UIImageView!
    var ur: UIImageView!
    var bl: UIImageView!
    var br: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupCornerTrim()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCornerTrim()
    }
    
    func setupCornerTrim(){
        
        tl = UIImageView(image: #imageLiteral(resourceName: "scale_tl"))
        tl.contentMode = .scaleAspectFill
        self.addSubview(tl)
        ur = UIImageView(image: #imageLiteral(resourceName: "scale_ur"))
        
        self.addSubview(ur)
        bl = UIImageView(image: #imageLiteral(resourceName: "scale_bl"))
        
        self.addSubview(bl)
        br = UIImageView(image: #imageLiteral(resourceName: "scale_br"))
        
        self.addSubview(br)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        br.frame = CGRect(x: self.bounds.maxX - 49, y: self.bounds.maxY - 49, width: 50, height: 50)
        bl.frame = CGRect(x: -1, y: self.bounds.maxY - 49, width: 50, height: 50)
        ur.frame = CGRect(x: self.bounds.maxX - 49, y: -1, width: 50, height: 50)
        tl.frame = CGRect(x: -1, y: -1, width: 50, height: 50)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(rect: self.bounds)
        let color = UIColor.lightGray
        color.setStroke()
        //path.stroke()
        let dashes : [CGFloat] = [10.0, 5.0 ]
        path.lineWidth = 3
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path.stroke()
        
        
    }
    //    func handlePan(recognizer : UIPanGestureRecognizer){
    //        let loc = recognizer.translation(in: self)
    //
    //        switch recognizer.state {
    //        case .began:
    //            print("began")
    //        case .changed:
    //            print("changed")
    //            //self.bounds = CGRect(x: self.bounds.minX + loc.x, y: self.bounds.minY + loc.y, width: self.bounds.maxX, height: self.bounds.maxY)
    //        case .ended:
    //            print("ended")
    //        default:
    //            break
    //        }
    //    
    //    }
    
    
}
