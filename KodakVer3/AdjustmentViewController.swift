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
    var x : CGFloat!
    var y : CGFloat!
    
    var onOKpressed: ((_ image : UIImage) -> Void)? = nil
    
    @IBAction func cancel(_ sender: UIButton) {
        prevTranslateX = 0.0
        prevTranslateY = 0.0
        lastScale = 0.0
        updateUI()
        print("reset pressed")
    }
    
    
    @IBAction func rotate(_ sender: UIButton) {
        print("rotate presssd")
        portrait = !portrait
        cont.portrait = portrait
        gest.portrait = portrait
        
        updateUI()
    }
    @IBAction func okButtonPressed(_ sender: UIButton) {
        self.onOKpressed!(image)
        print("ok pressed")
        _ = self.navigationController?.popViewController(animated: false)
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
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    var myRect2: CustomRectangle2!
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: false, completion: nil)
    }
    
    var newFrame : CGRect!
    
    func pan(pan: UIPanGestureRecognizer){
        //let width = imageView.frame.width
        let dis = pan.translation(in: gest)
        
        
        if pan.state == .began{
            myRect2 = CustomRectangle2(rect2: imageView.frame)
            newFrame = imageView.frame
            imageView.transform.tx = 0
            
        }else if pan.state == .changed{
            newFrame = myRect2.getNewRect(transX: dis.x, transY: dis.y)
            
            if newFrame.intersects(sizeHelperRect){
                self.x = dis.x
                self.y = dis.y
                imageView.frame = myRect2.getNewRect(transX: x, transY: y)
                
            }else{
                //detect collision of edges if two rects dont intersect
                //detect left collision
                if newFrame.maxX < sizeHelperRect.minX{
                    
                    self.y = dis.y
                    let rect = myRect2.getNewRect(transX: x, transY: y)
                    imageView.frame = CGRect(x: sizeHelperRect.minX - rect.width, y: rect.minY, width: rect.width, height: rect.height)
                }
                // detect right edge collision
                if newFrame.minX > sizeHelperRect.maxX{
                    
                    self.y = dis.y
                    let rect = myRect2.getNewRect(transX: x, transY: y)
                    imageView.frame = CGRect(x: sizeHelperRect.maxX, y: rect.minY, width: rect.width, height: rect.height)
                    
                    
                    
                }
                // detect top edge collision
                if newFrame.maxY < sizeHelperRect.minY{
                    if newFrame.maxX < sizeHelperRect.minX{
                        let rect = myRect2.getNewRect(transX: x, transY: y)
                        imageView.frame = CGRect(x: sizeHelperRect.minX - rect.width, y: sizeHelperRect.minY - rect.height
                            , width: rect.width, height: rect.height)
                        
                    }else{
                        if newFrame.minX > sizeHelperRect.maxX{
                            let rect = myRect2.getNewRect(transX: x, transY: y)
                            imageView.frame = CGRect(x: sizeHelperRect.maxX, y: sizeHelperRect.minY - rect.height, width: rect.width, height: rect.height)
                            
                        }else{
                            
                            self.x = dis.x
                            let rect = myRect2.getNewRect(transX: x, transY: y)
                            imageView.frame = CGRect(x: rect.minX, y: sizeHelperRect.minY - rect.height, width: rect.width, height: rect.height)
                        }
                    }
                }
                // detect bottom edge collision
                if newFrame.minY > sizeHelperRect.maxY{
                    if newFrame.maxX < sizeHelperRect.minX{
                        let rect = myRect2.getNewRect(transX: x, transY: y)
                        imageView.frame = CGRect(x: sizeHelperRect.minX - rect.width, y: sizeHelperRect.maxY
                            , width: rect.width, height: rect.height)
                        
                    }else{
                        
                        if newFrame.minX > sizeHelperRect.maxX{
                            let rect = myRect2.getNewRect(transX: x, transY: y)
                            imageView.frame = CGRect(x: sizeHelperRect.maxX, y: sizeHelperRect.maxY
                                , width: rect.width, height: rect.height)
                            
                        }else{
                            self.x = dis.x
                            let rect = myRect2.getNewRect(transX: x, transY: y)
                            imageView.frame = CGRect(x: rect.minX, y: sizeHelperRect.maxY
                                , width: rect.width, height: rect.height)
                        }
                        
                    }
                    
                    
                }
                
                
                
            }
            
            
        }
        
    }
    var lastScale: CGFloat = 0.0
    var minScale : CGFloat!
    var maxScale : CGFloat!
    
    
    func pinchHandler(sender: UIPinchGestureRecognizer){
        
        if sender.state == .began{
            
            if imageView.transform.isIdentity{
                newFrame = imageView.frame
                
            }
            
        }else if sender.state == .changed{
            let x = newFrame.width - (newFrame.width * sender.scale)
            let scale = sender.scale
            
            if (newFrame.width > (sizeHelperRect.width / 4) && x > 0.0) || (newFrame.width < (sizeHelperRect.width * 4) && x < 0.0){
                
                if newFrame.intersects(sizeHelperRect){
                    
                    let rect = getScaledRectangle(transX: newFrame.midX, transY: newFrame.midY, scaleX: scale, scaleY: scale)
                    newFrame = rect
                    imageView.frame = rect
                    newFrame = imageView.frame
                    sender.scale = 1.0
                    
                }else{
                    if x > 0.0{
                        // left edge
                        if (newFrame.maxX <= sizeHelperRect.minX) && (x > 0.0){
                            print("left edge")
                            if newFrame.maxY <= sizeHelperRect.minY{
                                
                                let rect = getScaledRectangle(transX: newFrame.maxX, transY: newFrame.maxY, scaleX: scale, scaleY: scale)
                                newFrame = rect
                                imageView.frame = rect
                                
                                sender.scale = 1.0
                                
                            }else{
                                
                                if newFrame.minY >= sizeHelperRect.maxY{
                                    let rect = getScaledRectangle(transX: newFrame.maxX, transY: newFrame.minY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                    
                                }else{
                                    let rect = getScaledRectangle(transX: newFrame.maxX, transY: newFrame.midY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    
                                    sender.scale = 1.0
                                }
                                
                            }
                            
                            
                            
                        }
                        //top edge
                        if (newFrame.maxY <= sizeHelperRect.minY) && (x > 0.0){
                            
                            if newFrame.maxX <= sizeHelperRect.minX{
                                
                                print("top right detected")
                                let rect = getScaledRectangle(transX: newFrame.maxX, transY: newFrame.maxY, scaleX: scale, scaleY: scale)
                                newFrame = rect
                                imageView.frame = rect
                                sender.scale = 1.0
                                
                            }else{
                                
                                if newFrame.minX >= sizeHelperRect.maxX{
                                    let rect = getScaledRectangle(transX: newFrame.minX, transY: newFrame.maxY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                    print("dummy if true")
                                    
                                }else{
                                    let rect = getScaledRectangle(transX: newFrame.midX, transY: newFrame.maxY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                    print("dummy if false")
                                }
                                
                            }
                            
                            
                            
                        }
                        //right edge
                        if (newFrame.minX >= sizeHelperRect.maxX) && (x > 0.0){
                            print("right edge")
                            if newFrame.maxY <= sizeHelperRect.minY{
                                
                                let rect = getScaledRectangle(transX: newFrame.minX, transY: newFrame.maxY, scaleX: scale, scaleY: scale)
                                newFrame = rect
                                imageView.frame = rect
                                sender.scale = 1.0
                                
                            }else{
                                if newFrame.minY >= sizeHelperRect.maxY{
                                    let rect = getScaledRectangle(transX: newFrame.minX, transY: newFrame.minY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                }else{
                                    let rect = getScaledRectangle(transX: newFrame.minX, transY: newFrame.midY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                }
                                
                            }
                            
                            
                        }
                        // bottom edge
                        if (newFrame.minY >= sizeHelperRect.maxY) && (x > 0.0){
                            print("bottom edge")
                            if newFrame.maxX <= sizeHelperRect.minX{
                                let rect = getScaledRectangle(transX: newFrame.maxX, transY: newFrame.minY, scaleX: scale, scaleY: scale)
                                newFrame = rect
                                imageView.frame = rect
                                sender.scale = 1.0
                            }else{
                                if newFrame.minX >= sizeHelperRect.maxX{
                                    let rect = getScaledRectangle(transX: newFrame.minX, transY: newFrame.minY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                    
                                }else{
                                    
                                    let rect = getScaledRectangle(transX: newFrame.midX, transY: newFrame.minY, scaleX: scale, scaleY: scale)
                                    newFrame = rect
                                    imageView.frame = rect
                                    sender.scale = 1.0
                                    
                                }
                                
                            }
                            
                        }
                        
                    }else{
                        
                        let rect = getScaledRectangle(transX: newFrame.midX, transY: newFrame.midY, scaleX: scale, scaleY: scale)
                        newFrame = rect
                        imageView.frame = rect
                        sender.scale = 1.0
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    func getScaledRectangle(transX tX: CGFloat,transY tY: CGFloat, scaleX sX: CGFloat, scaleY sY: CGFloat) ->CGRect{
        let t0 = CGAffineTransform(translationX: -tX, y: -tY)
        
        let ts = CGAffineTransform(scaleX: sX, y: sY)
        
        let t1 = CGAffineTransform(translationX: tX, y: tY)
        
        let t = t0.concatenating(ts).concatenating(t1)
        
        return newFrame.applying(t)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
    }
    
}
extension UIImageView{
    
    func scaleImageViewFrame(scale s: CGFloat) -> CGRect{
        let scale: CGFloat = s
        let widthScale = (self.frame.size.width * scale)
        let heightScale = (self.frame.size.height * scale)
        let x = (self.frame.minX * scale) - self.frame.minX
        let y = (self.frame.minY * scale) - self.frame.minY
        
        print(self.frame.origin.x)
        print(self.frame.origin.y)
        return CGRect(x: self.frame.origin.x - (x * 2), y: self.frame.origin.y - (y * 2), width: widthScale, height: heightScale)
        
    }
    
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
    
    func frameForImageInImageViewAspectFit() ->CGRect{
        
        if let img = self.image{
            
            let imageRatio = img.size.width / img.size.height
            let viewRatio = self.frame.size.width / self.frame.size.height
            
            if (viewRatio > imageRatio){
                let scale = self.frame.size.height / img.size.height
                let width = scale * img.size.width
                let topLeft = (self.frame.size.width - width) * 0.5
                
                let rect = CGRect(x: topLeft, y: 0, width: width, height: self.frame.size.height)
                return rect
                
            }else{
                let scale = self.frame.size.width / img.size.width
                let height = scale * img.size.height
                let top = (self.frame.size.height - height) * 0.5
                let rect = CGRect(x: 0, y: top, width: self.frame.size.width, height: height)
                return rect
                
            }
            
        }
        
        
        return .zero
    }
    
}
