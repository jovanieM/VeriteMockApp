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
    var toggler : Bool = false
    
    @IBOutlet weak var toggleButton: UIButton!{
        didSet{
            toggleButton.setImage(#imageLiteral(resourceName: "copy_detect"), for: .selected)
        }
    }
    
    @IBOutlet weak var flickLabel: UILabel!
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    @IBOutlet weak var swipImage: UIImageView!
    
    @IBOutlet weak var settingsDisplay: UIView!
    
    @IBAction func hintDisplayToggle(_ sender: UIButton) {
        
        
        toggler = !toggler
        sender.isSelected = toggler
        toggle(tog: toggler)
        
    }
   
    func toggle(tog : Bool){
        if tog == true{
            container.alpha = 1.0
            flickLabel.alpha = 0.0
            swipeLabel.alpha = 0.0
            swipImage.alpha = 0.0
            settingsDisplay.alpha = 0.0
            
        }else{
            container.alpha = 0.6
            flickLabel.alpha = 1.0
            swipeLabel.alpha = 1.0
            swipImage.alpha = 1.0
            settingsDisplay.alpha = 1.0
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(pan:)))
        let pinchZoom = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(sender:)))
        pinchZoom.delegate = self
        
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
        container.alpha = 0.5
        //container.addGestureRecognizer(pan)
        container.addGestureRecognizer(pinchZoom)
        container.addGestureRecognizer(pan)


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
    
    var cont : CGFloat = 0.0
    
    func pinchHandler(sender: UIPinchGestureRecognizer){
        print(sender.scale)
        //var cont: CGFloat = 0.0
        var initial : CGFloat!
        
        if sender.state == .began{
            print("began \(sender.scale)")
            initial = sender.scale
            if cont != 0.0{
                cont = cont - initial
            }
            
        }else if sender.state == .changed{
            let newScale = sender.scale + cont
            if newScale >= 1.0 {
                
                imageView.transform = CGAffineTransform(scaleX: newScale, y: newScale)

            }
            
        }else if sender.state == .ended{
            print("ended \(sender.scale)")
            
            let s = sender.scale + cont
            if s >= 1.0{
                cont = s
                imageView.transform = CGAffineTransform(scaleX: s, y: s)
            }else{
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                cont = 0.0
            }
            
//            let sca = sender.scale
//            scale = sca - initial
//            
           
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

   
    

    

}
