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
        
        
        visibleViewController?.navigationController?.delegate = self
      
        
       
        //visibleViewController?.navigationController?.navigationBar.topItem?.title = "hello"
       
    }
    
    
    let back = "< back "
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
       //navigationController?.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "apptop"))
        let attrs: [String: Any] = [NSForegroundColorAttributeName : UIColor.gold, NSFontAttributeName : UIFont(name : "Arial", size : 12)!]
        
        visibleViewController?.navigationController?.navigationBar.tintColor = UIColor.gold
        viewController.navigationController?.navigationBar.backIndicatorImage = UIImage()
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
       
        let item: UIBarButtonItem = UIBarButtonItem(title: back, style: .plain, target: self, action: #selector(self.pop))
        item.setTitleTextAttributes(attrs, for: .normal)
       
        viewController.navigationItem.leftBarButtonItem = item
        
        super.pushViewController(viewController, animated: animated)

        
    }
    
    func pop(){
        
        
      
        if (viewControllers.last?.description.contains("AdjustmentViewController"))!{
            popViewController(animated: false)
        }else if (viewControllers.last?.description.contains("PrintQueueViewController"))!{
            viewControllers.last?.performSegue(withIdentifier: "backToImageFolders", sender: viewControllers.last)
 

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
