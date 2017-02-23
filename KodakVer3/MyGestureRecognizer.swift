//
//  MyGestureRecognizer.swift
//  KodakVer3
//
//  Created by jmolas on 2/22/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class MyGestureRecognizer: UIGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        print("began")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        print("ended")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        print("moved")
    }

}
