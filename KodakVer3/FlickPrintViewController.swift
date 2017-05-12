//
//  FlickPrintViewController.swift
//  KodakVer3
//
//  Created by jmolas on 2/21/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class FlickPrintViewController: UIViewController, UIGestureRecognizerDelegate{
    
    
    
    var sizes: [String] = ["4x6 in.", "4x6 in. Borderless", "3x5 in", "5x7 in.", "5x7 in. Borderless", "3.5x5 in.(L)", "3.5x5 in.(L) Borderless", "Letter", "Letter Borderless", "Legal", "Executive", "Statement", "A4", "A4 Borderless", "JIS B5", "A5", "A5 Borderless", "A6", "A6 Borderless", "Hagaki", "Hagaki BorderLess", "10 Envelope", "DL envelope", "C5 Envelope"]
    var types: [String] = ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"]
    var quality: [String] = ["Automatic", "Normal", "Best", "Draft"]
    
    
    @IBOutlet weak var printSettingsPrev: PrintSettingsPreview!{
        didSet{
            
            updateUI()
        }
    }
    
    
    
    func updateUI(){
        
        let vc = PrintPhotoVC()
        printSettingsPrev.paperSize.text = sizes[vc.getSavedData(receiver: 1)!]
        printSettingsPrev.paperType.text = types[vc.getSavedData(receiver: 3)!]
        printSettingsPrev.printQuality.text = quality[vc.getSavedData(receiver: 4)!]
        
        
        
    }
    
    
    @IBOutlet weak var container: UIView!
    
    var imageView: UIImageView!
    var image: UIImage!
    var toggler : Bool = false
    
    
    
    @IBOutlet weak var toggleButton: UIButton!{
        didSet{
            toggleButton.setImage(#imageLiteral(resourceName: "copy_detect"), for: .selected)
        }
    }
    
    
    @IBAction func settingButton(_ sender: UIButton) {
        let settingSB = UIStoryboard(name: "PhotoPrintSettingsStoryboard", bundle: nil)
        let vc = settingSB.instantiateInitialViewController()!
        self.show(vc, sender: self)
        //printPhoto()
    }
    @IBOutlet weak var flickLabel: UILabel!
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    @IBOutlet weak var swipImage: UIImageView!
    
    //    @IBOutlet weak var settingsDisplay: UIView!
    
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
            printSettingsPrev.alpha = 0.0
            
            
        }else{
            container.alpha = 0.6
            flickLabel.alpha = 1.0
            swipeLabel.alpha = 1.0
            swipImage.alpha = 1.0
            printSettingsPrev.alpha = 1.0
            //            settingsDisplay.alpha = 1.0
        }
        
    }
    let pd = PrintData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printSettingsPrev.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //printSettingsPrev = Bundle.loadNibNamed(<#T##Bundle#>)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(pan:)))
        let pinchZoom = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(sender:)))
        pinchZoom.delegate = self
        pd.thumbNail = image
        
        
        imageView = UIImageView()
        
        //container.addGestureRecognizer(pan)
        container.addGestureRecognizer(pinchZoom)
        container.addGestureRecognizer(pan)
        
        
    }
    override func viewDidLayoutSubviews() {
        //updateUI()
        imageView.contentMode = .scaleAspectFit
        //let insets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        imageView.image = image
        imageView.backgroundColor = .white
        
        //print(scrollView.bounds)
        //let scaleFactor = image.size.height / image.size.width
        
        imageView.frame = container.frame
        imageView.center.y = container.bounds.midY
        
        //imageView.center.y = container.bounds.midY
        
        container.addSubview(imageView)
        container.alpha = 0.75
        
        
    }
    
    
    func pan(pan: UIPanGestureRecognizer){
        var newCenter = pan.translation(in: container)
        
        if pan.state == .began{
            
        }else if pan.state == .changed{
            newCenter = pan.translation(in: container)
            if cont > 0.0{
                
                imageView.center.x = container.bounds.midX + newCenter.x
                imageView.center.y = container.bounds.midY + newCenter.y
            }else{
                let newY = newCenter.y
                imageView.center.y = container.bounds.midY + newY
            }
            
            
        }else if pan.state == .ended{
            
            if pan.translation(in: container).y > 0.0 {
                imageView.center.x = container.bounds.midX
                imageView.center.y = container.bounds.midY
            }
            if pan.translation(in: container).y > (-150.0){
                imageView.center.x = container.bounds.midX
                imageView.center.y = container.bounds.midY
                
            }
            if newCenter.y < (-150.0){
                printPhoto()
            }
            
        }
        
    }
    
    func printPhoto(){
        let sb = UIStoryboard(name: "PrintQueueStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "printQueue") as! PrintQueueViewController
        vc.printData = [pd]
        self.navigationController?.show(vc, sender: self)
        //show(vc, sender: self)
        
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
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AdjustmentViewController
        vc.image = self.image
        vc.onOKpressed = {
            (im) in
            self.imageView.image = im
        }
    }
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        print("view will appear flick")
        updateUI()
    }
    
    
}


extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
