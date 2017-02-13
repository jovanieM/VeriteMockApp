//
//  MyNavBar.swift
//  KodakVer3
//
//  Created by jmolas on 1/19/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class MyNavBar: UINavigationBar {
    
    
  
    override func popItem(animated: Bool) -> UINavigationItem? {
        print("popItem")

        return super.popItem(animated: false)
    }
    override func pushItem(_ item: UINavigationItem, animated: Bool) {
        print("pushItem")
        super.pushItem(item, animated: true)
      
        
    }
}
