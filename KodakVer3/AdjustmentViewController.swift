//
//  AdjustmentViewController.swift
//  KodakVer3
//
//  Created by jmolas on 2/24/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class AdjustmentViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var curtainView: UIView!
    
    var portrait : Bool!
    var extendedWidth : CGFloat!
    
    var imageView : UIImageView!
    
    var imageAspect : CGFloat!
    var imageViewAspect : CGFloat!
    var imageActualRect : CGRect = .zero
    var window : CGRect!
    var originalRectOfImage : CGRect!
    var sizeHelperRect : CGRect!
    

    @IBAction func cancel(_ sender: UIButton) {
        prevTranslateX = 0.0
        prevTranslateY = 0.0
        lastScale = 0.0
        updateUI()
    }
    
  
    @IBAction func rotate(_ sender: UIButton) {
        
        portrait = !portrait
        cont.portrait = portrait
        gest.portrait = portrait
        
        updateUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        curtainView.isHidden = true
    }
    
   
    // MARK: - UpdateUI()
    func updateUI(){
        imageFrame = SizeHelper(frame: cont.bounds, orientation: portrait)
        imageView.frame = CGRect(origin: imageFrame.origin, size: imageFrame.size)
        
        
        imageView.frame = imageView.frameForImageInImageViewAspectfill()
        
        imageView.center = cont.center
        sizeHelperRect = imageFrame.getRect(portrait: portrait)
        
        
        
        self.view.setNeedsLayout()
        gest.setNeedsDisplay()
        cont.setNeedsDisplay()
        print("update UI")
        print(sizeHelperRect)
        print(imageView.frame)
    }
    
    var origin : CGPoint!
    var imageFrame: SizeHelper!
    
    @IBOutlet weak var gest: BoxForeground!{
        didSet{
            gest.portrait = portrait
        }
    }
    
    @IBOutlet weak var cont: BoxBackGround!{
        didSet{
            cont.portrait = portrait
        }
    }
    
    
    var image : UIImage!{
        didSet{
            
            portrait = image.size.height > image.size.width ? true : false
            imageAspect = min(image.size.width, image.size.height) / max(image.size.width, image.size.height)
            print("image aspect = \(min(image.size.width, image.size.height) / max(image.size.width, image.size.height))")
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad \(cont.frame)")
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(pan:)))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(sender:)))
        pinch.delegate = self
        
        imageView = UIImageView()
        imageView.frame = .zero
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        cont.addSubview(imageView)
        gest.addGestureRecognizer(pan)
        gest.addGestureRecognizer(pinch)
        
        curtainView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    override func viewDidLayoutSubviews() {
        updateUI()
        
        print(imageView.frame.size)
        print(image.size)
        
        print("didLayout \(imageView.frame.midY)")
        print("didLayout \(gest.bounds.midY)")
        print("didLayout \(imageFrame.origin)")
        print("didLayout \(imageView.frame.origin)")
        
        print("imageViewImageSize \(imageView.frameForImageInImageViewAspectfill().size.width)")
        print("imageViewSize \(imageView.frame.size.width)")
        
        
    }
    
    var initialCenter : CGPoint!
    var isHitX : Bool = false
    var savePointX : CGFloat = 0.0
    var pressed : Bool = false
    var transX : CGFloat!
    //var ranges : Range = Range()
    var prevTranslateX : CGFloat = 0.0
    var prevTranslateY : CGFloat = 0.0
    var lastTranslate : CGFloat!
    var counter = 0
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: false, completion: nil)
    }
    
    func pan(pan: UIPanGestureRecognizer){
        //let width = imageView.frame.width
        let dis = pan.translation(in: gest)
        //print(pan.setTranslation(.init(x: 10.0, y: 10.0), in: gest))
        
        
        if pan.state == .began{
            
            
        }else if pan.state == .changed{
            
            if dis.x + 2.0 < 0.0 && abs(dis.x + prevTranslateX) < (imageView.frame.size.width * 0.5) + (imageFrame.size.width * 0.5) + 2.0
            {
                imageView.center.x = gest.bounds.midX +  dis.x
                
            }
            
            if dis.x + 2.0 > 0.0 && abs(dis.x + prevTranslateX) < (imageView.frame.size.width * 0.5) + (imageFrame.size.width * 0.5) + 2.0
            {
                imageView.center.x = gest.bounds.midX + dis.x
            }
            
            if dis.y + 2.0 < 0.0 && abs(dis.y + prevTranslateY) < (imageView.frame.size.height * 0.5) + (imageFrame.size.height * 0.5) + 2.0
            {
                imageView.center.y = gest.bounds.midY + dis.y
            }
            
            if dis.y + 2.0 > 0.0 && abs(dis.y + prevTranslateY) < (imageView.frame.size.height * 0.5) + (imageFrame.size.height * 0.5) + 2.0
            {
                imageView.center.y = gest.bounds.midY + dis.y
                
            }
        }else if pan.state == .ended{
            pan.setTranslation(dis, in: gest)
            
            
            
            //            if abs(lastTranslateX) < (imageView.frame.size.width * 0.5) + (imageFrame.size.width * 0.5) + 2.0{
            //                prevTranslateX =  lastTranslateX
            //            }else{
            //                prevTranslateX = 0.0
            //            }
            //            if abs(lastTranslateY) < (imageView.frame.size.height * 0.5) + (imageFrame.size.height * 0.5) + 2.0{
            //                prevTranslateY = lastTranslateY
            //            }else{
            //                prevTranslateY = 0.0
            //            }
            
            //            imageView.center.x = gest.bounds.midX + dis.x
            //            imageView.center.y = gest.bounds.midY + dis.y
            //savePointX = round(pan.translation(in: gest).x) + savePointX
            
            
            //            if pan.translation(in: gest).y > 0.0 {
            //                imageView.center.x = gest.bounds.midX
            //                imageView.center.y = gest.bounds.midY
            //            }
            
        }
        else if pan.state == .failed{
            
        }
        
    }
    var lastScale: CGFloat = 0.0
    
    func pinchHandler(sender: UIPinchGestureRecognizer){
        
        //var cont: CGFloat = 0.0
        let initial : CGFloat!
        let rect = CGRect(x: 70, y: 70, width: 300, height: 400)
        if sender.state == .began{
            
            initial = sender.scale
            if lastScale != 0.0{
                lastScale = lastScale - initial
            }
            
        }else if sender.state == .changed{
            let newScale = sender.scale + lastScale
            if newScale >= 0.28 && newScale <= 7.0 {
                if !imageView.frame.intersects(rect){
                    print("not intersect")
                    imageView.center.x = gest.bounds.midX + (imageFrame.size.width / 2) + (imageView.frame.size.width / 2)
                    
                }
                imageView.transform = CGAffineTransform(scaleX: newScale, y: newScale)
                
            }
            
        }else if sender.state == .ended{
            
            
            let s = sender.scale + lastScale
            
            if s >= 0.28 && s <= 7.0{
                lastScale = s
                imageView.transform = CGAffineTransform(scaleX: s, y: s)
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
    
    
    
}
extension UIImageView{
    
    func frameForImageInImageViewAspectfill() -> CGRect{
        
        
        if let img = self.image{
            let imageRatio = img.size.width / img.size.height
            let viewRatio = self.frame.size.width / self.frame.size.height
            
            if (imageRatio > viewRatio){
                let scale = self.frame.size.height / img.size.height
                let width = scale * img.size.width
                let topLeft = (self.frame.size.width - width) * 0.5
                return CGRect(x: topLeft, y: 0, width: width, height: self.frame.size.height)
            }else{
                let scale = self.frame.size.width / img.size.width
                let height = scale * img.size.height
                let top = (self.frame.size.height - height) * 0.5
                return CGRect(x: 0, y: top, width: self.frame.size.width, height: height)
            }
            
        }
        return .zero
    }
    
}
