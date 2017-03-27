//
//  LoadInstructionsViewController.swift
//  KodakVer3
//
//  Created by SQA on 24/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit



class LoadInstructionsViewController: UIViewController {

    @IBOutlet weak var OKbutton: UIButton!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var envelopeImage: UIImageView!
    
    @IBOutlet weak var envelopeName: UILabel!
    @IBOutlet weak var envelopeDescription: UILabel!
    
    
    
    let animationImages1:[UIImage] = [UIImage(named: "ap_setenvelope04")!,
                                       UIImage(named: "ap_setenvelope04")!,
                                       UIImage(named: "ap_setenvelope05")!,
                                       UIImage(named: "ap_setenvelope06")!,
                                       UIImage(named: "ap_setenvelope07")!,
                                       UIImage(named: "ap_setenvelope08")!,
                                       UIImage(named: "ap_setenvelope09")!,
                                       UIImage(named: "ap_setenvelope10")!,
                                       UIImage(named: "ap_setenvelope11")!,
                                       UIImage(named: "ap_setenvelope12")!,
                                       UIImage(named: "ap_setenvelope13")!,
                                       UIImage(named: "ap_setenvelope13")!,
                                       UIImage(named: "ap_setenvelope13")!,
                                       UIImage(named: "ap_setenvelope14")!,
                                       UIImage(named: "ap_setenvelope15")!,
                                       UIImage(named: "ap_setenvelope16")!,
                                       UIImage(named: "ap_setenvelope17")!,
                                       UIImage(named: "ap_setenvelope18")!,
                                       UIImage(named: "ap_setenvelope18")!,
                                       UIImage(named: "ap_setenvelope18")!]
    
    
    let animationImages2:[UIImage] = [UIImage(named: "ap_setenvelope04")!,
                                      UIImage(named: "ap_setenvelope04")!,
                                      UIImage(named: "ap_setenvelope04")!,
                                      UIImage(named: "ap_setenvelope05")!,
                                      UIImage(named: "ap_setenvelope06")!,
                                      UIImage(named: "ap_setenvelope07")!,
                                      UIImage(named: "ap_setenvelope08")!,
                                      UIImage(named: "ap_setenvelope09")!,
                                      UIImage(named: "ap_setenvelope69-10")!,
                                      UIImage(named: "ap_setenvelope69-11")!,
                                      UIImage(named: "ap_setenvelope69-12")!,
                                      UIImage(named: "ap_setenvelope69-13")!,
                                      UIImage(named: "ap_setenvelope69-13")!,
                                      UIImage(named: "ap_setenvelope69-13")!,
                                      UIImage(named: "ap_setenvelope69-14")!,
                                      UIImage(named: "ap_setenvelope69-15")!,
                                      UIImage(named: "ap_setenvelope69-16")!,
                                      UIImage(named: "ap_setenvelope69-17")!,
                                      UIImage(named: "ap_setenvelope69-18")!,
                                      UIImage(named: "ap_setenvelope69-18")!,
                                      UIImage(named: "ap_setenvelope69-18")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OKbutton.layer.cornerRadius = 15;
        OKbutton.layer.borderWidth = 1;
        OKbutton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        OKbutton.layer.masksToBounds = true;
        loadingImageView.animationImages = animationImages1
        loadingImageView.animationDuration = 15.0
        loadingImageView.animationRepeatCount = 0
        loadingImageView.startAnimating()
        self.view.addSubview(loadingImageView)
        

    }
}
