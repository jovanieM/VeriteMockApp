//
//  CustomRect.swift
//  KodakVer3
//
//  Created by jmolas on 5/2/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CustomRect: NSObject {
    
    var x : CGFloat!
    var y : CGFloat!
    var width : CGFloat!
    var height : CGFloat!
    
    func ulRectAdjuster(x: CGFloat, y: CGFloat, transX : CGFloat, transY : CGFloat) ->CGRect{
        return CGRect(x: x, y: y, width: width, height: height)
    }

}

struct CustomRectangle {
    
//    var x : CGFloat!
//    var y : CGFloat!
//    var width : CGFloat!
//    var height : CGFloat!
    var rect: CGRect!
    
    func detectCenterTouch() ->CGRect{
        return rect
    
    }
    
    func detectULTouch() ->CGRect {
        
        return CGRect(x: rect.minX - 10, y: rect.minY - 10, width: 40, height: 40)
    
    }
    func detectURTouch() ->CGRect {
        return CGRect(x: rect.maxX - 30, y: rect.minY - 10, width: 40, height: 40)
        
    }
    func detectBLTouch() ->CGRect {
        return CGRect(x: rect.minX - 10, y: rect.maxY - 30, width: 40, height: 40)
        
    }
    func detectBRTouch() ->CGRect {
        return CGRect(x: rect.maxX - 30, y: rect.maxY - 30, width: 40, height: 40)
        
    }
    
    func getCenterPressed(transX : CGFloat, transY : CGFloat) ->CGRect {
        return CGRect(x : self.rect.minX + transX, y : self.rect.minY + transY, width: self.rect.width , height: self.rect.height )
    }
    
    func getULRect(transX : CGFloat, transY : CGFloat) ->CGRect {
        
        return CGRect(x : self.rect.minX + transX, y : self.rect.minY + transY, width: self.rect.width - transX, height: self.rect.height - transY)
    }
    
    func getURRect(transX : CGFloat, transY : CGFloat) ->CGRect {
        
        return CGRect(x : self.rect.minX, y : self.rect.minY + transY, width: self.rect.width + transX, height: self.rect.height - transY)
    }

    
    func getBLRect(transX : CGFloat, transY : CGFloat) ->CGRect {
        
        return CGRect(x : self.rect.minX + transX, y : self.rect.minY, width: self.rect.width - transX, height: self.rect.height + transY)
    }

    func getBRRect(transX : CGFloat, transY : CGFloat) ->CGRect {
        
        return CGRect(x : self.rect.minX, y : self.rect.minY , width: self.rect.width + transX, height: self.rect.height + transY)
    }

    
}

struct CustomRectangle2 {
    var rect2: CGRect!
    
    func getNewRect(transX : CGFloat, transY : CGFloat) ->CGRect {
        return CGRect(x : self.rect2.minX + transX, y : self.rect2.minY + transY, width: self.rect2.width , height: self.rect2.height )
    }
}

public enum Direction: Int {
    case Up
    case Down
    case Left
    case Right
    
    public var isX: Bool { return self == .Left || self == .Right }
    public var isY: Bool { return !isX }
}

public extension UIPanGestureRecognizer{
    
    public var direction: Direction? {
        let vel = velocity(in: self.view)
        let vertical = fabs(vel.y) > fabs(vel.x)
        switch (vertical, vel.x, vel.y) {
        case (true, _, let y) where y < 0: return .Up
        case (true, _, let y) where y > 0: return .Down
        case (false, let x, _) where x > 0: return .Right
        case (false, let x, _) where x < 0: return .Left
        default: return nil
        }
    }
}
