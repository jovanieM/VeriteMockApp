//
//  PrintPhotoVC.swift
//  KodakVer3
//
//  Created by jmolas on 12/7/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit



class PrintPhotoVC: UIViewController  {

    
    @IBOutlet weak var iv: UIImageView!
   
   
    @IBOutlet weak var container: UIView!
  
    @IBOutlet weak var detail: UIView!
    
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var quickBtn: UIButton!
    
    
    
    var navbarHeight:CGFloat = UIScreen.main.bounds.height
    
    
   
    
    var gold: UIColor {
        return UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "mySegue"{
////            let detailVC: DetailViewController = segue.destination as! DetailViewController
////            detailVC.delegate = self
//            
//        }
//        
//        
//    }
    
    
    @IBAction func switcher(_ sender: UIButton) {
        let title = sender.currentTitle!
      
        
        if title == "Quick"{
            iv.image = #imageLiteral(resourceName: "settingtab_left")
            quickBtn.setTitleColor(gold, for: .normal)
            detailBtn.setTitleColor(.lightGray, for: .normal)
            self.detail.alpha = 0.0
            self.container.alpha = 1.0
        }else{
            iv.image = #imageLiteral(resourceName: "settingtab_right")
            quickBtn.setTitleColor(.lightGray, for: .normal)
            detailBtn.setTitleColor(gold, for: .normal)
            self.detail.alpha = 1.0
            self.container.alpha = 0.0
            
        }
        
    }

 

    override func viewDidLoad() {
        super.viewDidLoad()
    
        quickBtn.setTitleColor(gold, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
