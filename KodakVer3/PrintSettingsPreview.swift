//
//  PrintSettingsPreview.swift
//  KodakVer3
//
//  Created by jmolas on 3/21/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintSettingsPreview: UIView {
    
    var size: SettingsObject?{ didSet { paperSize.text = size?.paperSize } }
    var type : SettingsObject?{ didSet { paperType.text = type?.paperType } }
    var quality: SettingsObject?{ didSet { printQuality.text = quality?.printQuality } }
    
    @IBOutlet var containerView: UIView!{
        didSet{
            
            setNeedsDisplay()
        }
    }

    @IBOutlet weak var paperSize: UILabel!{
        didSet{
            setNeedsDisplay()
        }
    }
 
    @IBOutlet weak var paperType: UILabel!{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBOutlet weak var printQuality: UILabel!{
        didSet{
            
            setNeedsDisplay()
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        print("reuse view")
        self.quality = SettingsObject()
        self.size = SettingsObject()
        self.type = SettingsObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        self.quality = SettingsObject()
        self.size = SettingsObject()
        self.type = SettingsObject()
        print("reuse view")
    //Bundle.main.loadNibNamed("PrintSettingsPreview", owner: self, options: nil)
    }
    private func initSubviews(){
        
        let nib = UINib(nibName: "PrintSettingsPreview", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        
    
    }
   

}
