//
//  FlickPrintViewController.swift
//  KodakVer3
//
//  Created by jmolas on 2/21/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class FlickPrintViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var container: UIView!
    var imageView: UIImageView!
    var image: UIImage!
   
    //var scaleFactor: CGFloat!
    
      
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(pan:)))
        let pinchZoom = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(sender:)))
        
        //pan.delegate = self
        //let pan2 = MyGestureRecognizer(target: self, action: #selector(pan(pan:)))
        
        imageView = UIImageView()
        
        //print(scrollView.bounds)
        let scaleFactor = image.size.height / image.size.width
        
        imageView.frame = CGRect(x: 0, y: 0, width: container.bounds.width, height: container.bounds.width * scaleFactor)
        
        imageView.contentMode = .scaleAspectFill
        imageView.center.y = container.bounds.midY
        print(container.frame)
    
        imageView.image = image
        container.addSubview(imageView)
        //container.addGestureRecognizer(pan)
        container.addGestureRecognizer(pinchZoom)
      
        
        
        
        print(image.size)

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
  
    func pan(pan: UIPanGestureRecognizer){
        
        if pan.state == .began{
            print("began")
            
        }else if pan.state == .changed{
            let newY = pan.translation(in: container).y
            imageView.center.y = container.bounds.midY + newY

            print(pan.translation(in: container).y)
        }else if pan.state == .ended{
            print("ended")
            if pan.translation(in: container).y > 0.0{
                imageView.center.y = container.bounds.midY
            }
        
        }
       
    }
    
    var scale: CGFloat!
    
    func pinchHandler(sender: UIPinchGestureRecognizer){
        print(sender.scale)
        var cont: CGFloat = 1.0
        var initial : CGFloat!
        
        if sender.state == .began{
            print("began \(sender.scale)")
            initial = sender.scale
            cont = scale - initial
            
        }else if sender.state == .changed{
            let newScale = cont
            if newScale >= 1.0 {
                
                imageView.transform = CGAffineTransform(scaleX: newScale, y: newScale)

            }
            
        }else if sender.state == .ended{
            print("ended \(sender.scale)")
            let sca = sender.scale
            scale = sca - initial
            imageView.transform = CGAffineTransform(scaleX: sca, y: sca)
           
        }
        
        
        
        
    }

   
    

    

}
