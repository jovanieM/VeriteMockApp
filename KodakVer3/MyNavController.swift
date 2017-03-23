//
//  MyNavController.swift
//  KodakVer3
//
//  Created by jmolas on 12/8/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit



class MyNavController: UINavigationController, UINavigationControllerDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barStyle = .blackOpaque
        
        self.navigationBar.isTranslucent = false
        //visibleViewController?.navigationController?.navigationItem.title = "Home"
        visibleViewController?.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
        visibleViewController?.navigationController?.delegate = self
       
        //visibleViewController?.navigationController?.navigationBar.topItem?.title = "hello"
       
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
       //navigationController?.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "apptop"))
        
        
        viewController.navigationController?.navigationBar.backIndicatorImage = UIImage()
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        let item: UIBarButtonItem = UIBarButtonItem(title: "< back", style: .plain, target: self, action: #selector(self.pop))
       
        viewController.navigationItem.leftBarButtonItem = item
        
        super.pushViewController(viewController, animated: animated)

        
    }
    
    func pop(){
        
        
      
        if (viewControllers.last?.description.contains("AdjustmentViewController"))!{
            popViewController(animated: false)

        }else{
            popViewController(animated: true)

        }
        
        //popViewController(animated: true)
        
    
        

    }
    

    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let height: CGFloat = (viewController.navigationController?.navigationBar.frame.height)!
        let imageView = UIImageView(image: #imageLiteral(resourceName: "apptop"))
        imageView.frame = CGRect(x: 0, y: 0, width: height * 1.47, height: height)
    
        imageView.contentMode = .scaleAspectFit
        viewController.navigationItem.titleView = imageView
//        viewController.navigationController?.navigationBar.backIndicatorImage = UIImage()
//        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        //viewController.navigationController?.navigationBar.topItem?.title = "hello"
               //viewController.navigationController?.navigationBar.backItem.
        //let bck = UIBarButtonItem(title: "<back", style: .plain, target: self, action: nil)

    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //let item: UIBarButtonItem = UIBarButtonItem(title: "<hello", style: .plain, target: self, action: nil)
        //item.backButtonTitlePositionAdjustment(for: .compact)
    }

}
