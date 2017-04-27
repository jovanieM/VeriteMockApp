//
//  CropViewController.swift
//  KodakVer3
//
//  Created by jmolas on 4/26/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let _ = UITapGestureRecognizer(target: self, action: #selector(handleCornerPan(sender:)))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleCornerPan(sender: UITapGestureRecognizer){
        
        print("any")
        let viewTag = sender.view?.tag
        print(viewTag!)
        if sender.state == .began{
            print("began")
        }
    
    }
    @IBAction func cornerPanGestRecog(pan : UIPanGestureRecognizer){
        if pan.state == .began{
            print("panned")
        }

        
        let view = pan.view!.tag
        
        switch view {
        case 1:
            print("TL")
        case 2:
            print("TR")
        case 3:
            print("BL")
        case 4:
            print("BR")
        default:
            print("any")
    
        }
    
    }
    

   
}
