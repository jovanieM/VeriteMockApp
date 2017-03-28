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
//            settingsDisplay.alpha = 0.0
//            for i in 0..<settingsDisplay.subviews.count{
//                print(settingsDisplay.subviews[i])
//            }
            
        }else{
            container.alpha = 0.6
            flickLabel.alpha = 1.0
            swipeLabel.alpha = 1.0
            swipImage.alpha = 1.0
            printSettingsPrev.alpha = 1.0
//            settingsDisplay.alpha = 1.0
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printSettingsPrev.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //printSettingsPrev = Bundle.loadNibNamed(<#T##Bundle#>)
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
        container.alpha = 0.75
        //container.addGestureRecognizer(pan)
        container.addGestureRecognizer(pinchZoom)
        container.addGestureRecognizer(pan)


    }
    override func viewDidLayoutSubviews() {
        updateUI()
        print("reloaded")
    }
    
  
    func pan(pan: UIPanGestureRecognizer){
        
        if pan.state == .began{
            
        }else if pan.state == .changed{
            let newcCenter = pan.translation(in: container)
            if cont > 0.0{
                
                imageView.center.x = container.bounds.midX + newcCenter.x
                imageView.center.y = container.bounds.midY + newcCenter.y
            }else{
                let newY = newcCenter.y
                imageView.center.y = container.bounds.midY + newY
            }
            if newcCenter.y < (-150.0){
                printPhoto()
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
        
        }
       
    }
    
    func printPhoto(){
        let sb = UIStoryboard(name: "PrintQueueStoryboard", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! PrintQueueViewController
        let pd = PrintData()
        pd.thumbNail = image
        vc.printData = [pd]
        self.show(vc, sender: self)
    
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
        
        
    }
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
        updateUI()
    }
    

   
    

    

}
