//
//  ScanPhotoSettingPreview.swift
//  KodakVer3
//
//  Created by jmolas on 4/24/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ScanPhotoSettingPreview: UIView {


    @IBOutlet var contentView2: UIView!
    
    @IBOutlet weak var scanPhotoQuality: UILabel!
    
    @IBOutlet weak var scanPhotoColor: UILabel!
    @IBOutlet weak var scanPhotoDocument: UILabel!

    
    override init(frame: CGRect){
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    private func initSubviews(){
        let nib = UINib(nibName: "ScanPhotoSettingsPreview", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView2)
        contentView2.frame = bounds
    }


}
