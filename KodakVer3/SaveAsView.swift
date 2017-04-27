//
//  SaveAsView.swift
//  KodakVer3
//
//  Created by jmolas on 4/17/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SaveAsView: UIView {
    var title : UILabel!
    var editTitle : UITextField!
    var cancel : UIButton!
    var save : UIButton!
    var container : UIView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
      //  container.frame = CGRect(x: 0, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }
    
    func addViews(){
        let container = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.458))
        container.backgroundColor = .white
        self.addSubview(container)
        
//        let title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: container.frame.height * 0.303))
//        title.text = "Save as"
//        container.addSubview(title)
//        
//        let textField = UITextField(frame: CGRect(x: 0, y: title.frame.maxY, width: self.frame.width, height: container.frame.height * 0.3030))
//        container.addSubview(textField)
//        
//        let cancel = UIButton(type: .custom)
//        cancel.frame = CGRect(x: 0, y: textField.frame.maxY, width: self.frame.width / 2, height: container.frame.height * 0.3030)
//        cancel.setTitle("Cancel", for: .normal)
//        cancel.layer.borderWidth = 2
//        cancel.layer.borderColor = UIColor.black.cgColor
//        container.addSubview(cancel)
//        
//        let save = UIButton(type: .custom)
//        save.frame = CGRect(x: self.frame.width / 2, y: textField.frame.maxY, width: self.frame.width / 2, height: container.frame.height * 0.3030)
//        save.setTitle("Save", for: .normal)
//        save.layer.borderWidth = 2
//        save.layer.borderColor = UIColor.black.cgColor
//        container.addSubview(save)
//        container.center = convert(center, from: self)
//        self.addSubview(container)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
