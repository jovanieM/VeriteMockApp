//
//  CropViewController.swift
//  KodakVer3
//
//  Created by jmolas on 4/26/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
protocol CropViewDelegate {
    func getImageFromCrop(image : UIImage?)
}

class CropViewController: UIViewController {
    
    var delegate : CropViewDelegate!
    
    var referenceRect : CGRect!
    var image : UIImage!
    var imageActualFrameInImageView : CGRect!
    var widthScale : CGFloat!
    var heightScale : CGFloat!
    var cropRect : CGRect!
    var myRect : CustomRectangle!
    var tlPressed : Bool = false
    var urPressed : Bool = false
    var blPressed : Bool = false
    var brPressed : Bool = false
    var centerPressed : Bool = false
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func cropOk(_ sender: UIButton) {
        delegate.getImageFromCrop(image: calculateCropArea(rect: cropRect, image: image))
        _ = navigationController?.popViewController(animated: false)
    }
    
    @IBAction func cropCancel1(_ sender: Any) {
        _ = navigationController?.popViewController(animated: false)
    }
    
    
    
    @IBOutlet weak var imView: UIImageView!
    
    var cropperView: CropperView!{
        didSet{
            cropperView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imView.image = image
    
        cropperView = CropperView(frame: .zero)
        cropperView.backgroundColor = UIColor.clear
        cropperView.contentMode = .redraw
        containerView.addSubview(cropperView)
        
        //print(imageRect)
        print(cropperView.frame)
        print(imView.frame)
        
        // cropperView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageRect = imView.frameForImageInImageViewAspectFit()
        
        cropperView.frame = imageRect
        cropperView.center = containerView.center
        referenceRect = cropperView.frame
        cropRect = cropperView.frame
        
        widthScale = image.size.width / cropperView.frame.width
        heightScale = image.size.height / cropperView.frame.height
        
        
        
    }
    
  
    func handlePan(recognizer: UIPanGestureRecognizer){
        let loc = recognizer.location(in: self.view)
        let trans = recognizer.translation(in: self.view)
        
        switch recognizer.state {
        case .began:
            
            myRect = CustomRectangle(rect: cropperView.frame)
            
            if myRect.detectCenterTouch().contains(loc){
                centerPressed = true
            }
            if myRect.detectULTouch().contains(loc){
                tlPressed = true
                centerPressed = false
                
            }
            if myRect.detectURTouch().contains(loc){
                urPressed = true
                centerPressed = false
                
            }
            if myRect.detectBLTouch().contains(loc){
                blPressed = true
                centerPressed = false
                
            }
            if myRect.detectBRTouch().contains(loc){
                brPressed = true
                centerPressed = false
                
            }
        case .changed:
            
            if centerPressed{
                let newFrame = myRect.getCenterPressed(transX: trans.x, transY: trans.y)
                
                cropperView.frame = newFrame
                
                
            }
            if tlPressed{
                let newFrame = myRect.getULRect(transX: trans.x, transY: trans.y)
                cropperView.frame = newFrame
            }
            if urPressed{
                let newFrame = myRect.getURRect(transX: trans.x, transY: trans.y)
                cropperView.frame = newFrame
            }
            if blPressed{
                let newFrame = myRect.getBLRect(transX: trans.x, transY: trans.y)
                cropperView.frame = newFrame
            }
            if brPressed{
                let newFrame = myRect.getBRRect(transX: trans.x, transY: trans.y)
                cropperView.frame = newFrame
            }
            
        case .ended:
            tlPressed = false
            urPressed = false
            blPressed = false
            brPressed = false
            //let rect = calculateCropArea(rect: cropperView.frame, image : image)
            
            cropRect = cropperView.frame.intersection(referenceRect)
            
            
        default:
            break
        }
        
    }
    func calculateCropArea(rect : CGRect, image : UIImage) -> UIImage? {
        
        var x : CGFloat = rect.origin.x
        var y : CGFloat = rect.origin.y
        let width = rect.width * widthScale
        let height = rect.height * heightScale
        if x == referenceRect.origin.x{
            x = 0
        }else{
            let dif = rect.origin.x - referenceRect.origin.x
            x = dif * widthScale
        }
        if y == referenceRect.origin.y{
            y = 0
        }else{
            let dif = rect.origin.y - referenceRect.origin.y
            y = dif * heightScale
        }
        
        if let cgIm =  image.cgImage?.cropping(to: CGRect(x: x, y: y, width: width, height: height)){
            return UIImage(cgImage: cgIm)
        }
        return nil
        
    }
    
    
}
