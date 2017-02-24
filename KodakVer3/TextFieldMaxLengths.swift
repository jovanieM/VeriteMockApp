//
//  TextFieldMaxLengths.swift
//  KodakVer3
//
//  Created by anarte on 24/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {

    @IBInspectable var maxLength: Int {
    get{
        guard let length = maxLengths[self] else{
                return Int.max
        }
        return length
    }
    set{
        maxLengths[self] = newValue
        
        addTarget(self, action: #selector(limitLength), for: UIControlEvents.editingChanged)
        }
}

    func limitLength(textField: UITextField){
        guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength else {
                return
        }
        
        let selection = selectedTextRange
        text = prospectiveText.substring(with: Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)))
        selectedTextRange = selection
    }
}
