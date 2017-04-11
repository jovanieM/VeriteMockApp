//
//  SettingsObject.swift
//  KodakVer3
//
//  Created by jmolas on 3/22/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SettingsObject : NSObject{
    
    var paperSize: String?
    var paperType: String?
    var printQuality: String?
  
  var copyColor: String?
  
    var sizes: [String] = ["4x6 in.", "4x6 in. Borderless", "3x5 in", "5x7 in.", "5x7 in. Borderless", "3.5x5 in.(L)", "3.5x5 in.(L) Borderless", "Letter", "Letter Borderless", "Legal", "Executive", "Statement", "A4", "A4 Borderless", "JIS B5", "A5", "A5 Borderless", "A6", "A6 Borderless", "Hagaki", "Hagaki BorderLess", "10 Envelope", "DL envelope", "C5 Envelope"]
    var types: [String] = ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"]
    var quality: [String] = ["Automatic", "Normal", "Best", "Draft"]

  var color: [String] = ["Color", "Black and White"]
}



