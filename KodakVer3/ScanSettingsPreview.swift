//
//  ScanSettingsPreview.swift
//  KodakVer3
//
//  Created by jmolas on 4/6/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ScanSettingsPreview: UIView {
    
    
    @IBOutlet var containerView: UIView!{
        didSet{
            setNeedsDisplay()
        }
    }
    
   
    @IBOutlet weak var docScanQuality: UILabel!{
        didSet{
            setNeedsDisplay()
        }
    }

    @IBOutlet weak var docScanColor: UILabel!{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBOutlet weak var docScanDocument: UILabel!{
        didSet{
            setNeedsDisplay()
        }
    }

    @IBOutlet weak var docScanSaveAsType: UILabel!{
        didSet{
            setNeedsDisplay()
        }
    }
    
  
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    private func initSubviews(){
        let nib = UINib(nibName: "ScanSettingsPreview", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
    }
    
}
