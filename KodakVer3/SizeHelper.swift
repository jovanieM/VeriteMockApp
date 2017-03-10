//
//  SizeHelper.swift
//  KodakVer3
//
//  Created by jmolas on 2/28/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SizeHelper{
    
    let landscapeScale: CGFloat = 0.66
    let portraitScale: CGFloat = 1.52
    var origin: CGPoint!
    var size: CGSize!
    var baseRect: CGRect
    //let portraitScale =
    
    
    convenience init(){
        self.init()
    }
    
    init(frame : CGRect, orientation portrait: Bool){
        
        self.baseRect = frame
        print("init hleper")
        if !portrait{
            
            let imgWidth = frame.width * 0.92
            let imgHeight = imgWidth * landscapeScale
            origin = CGPoint(x: frame.width / 2 - imgWidth / 2, y: frame.height / 2 - imgHeight / 2)
            size = CGSize(width: imgWidth, height: imgHeight)
            print("sizehelper \(frame.midX)")
            print("sizehelper \(frame.midY)")
            
        }else{
            
            let imgWidth = frame.width * 0.61
            let imgHeight = imgWidth * portraitScale
            origin = CGPoint(x: frame.width / 2 - imgWidth / 2, y: frame.height / 2 - imgHeight / 2)
            size = CGSize(width: imgWidth, height: imgHeight)
        }
       
    }
    
    func getRect(portrait: Bool)->CGRect{
        
        if !portrait{
            
            let imgWidth = baseRect.width * 0.92
            let imgHeight = imgWidth * landscapeScale
            origin = CGPoint(x: baseRect.width / 2 - imgWidth / 2, y: baseRect.height / 2 - imgHeight / 2)
            size = CGSize(width: imgWidth, height: imgHeight)
            return CGRect(origin: origin, size: size)
          
            
        }else{
            
            let imgWidth = baseRect.width * 0.61
            let imgHeight = imgWidth * portraitScale
            origin = CGPoint(x: baseRect.width / 2 - imgWidth / 2, y: baseRect.height / 2 - imgHeight / 2)
            size = CGSize(width: imgWidth, height: imgHeight)
            
           return CGRect(origin: origin, size: size)
        }
    
 
    }
    
    
   
}

