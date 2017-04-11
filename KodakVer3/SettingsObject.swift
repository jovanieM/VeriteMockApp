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
    
    var docScanQual: String!
    var docScanColor: String!
    var docScanDocument: String!
    var docScanSaveAsType: String?!
    
    var sizes: [String] = ["4x6 in.", "4x6 in. Borderless", "3x5 in", "5x7 in.", "5x7 in. Borderless", "3.5x5 in.(L)", "3.5x5 in.(L) Borderless", "Letter", "Letter Borderless", "Legal", "Executive", "Statement", "A4", "A4 Borderless", "JIS B5", "A5", "A5 Borderless", "A6", "A6 Borderless", "Hagaki", "Hagaki BorderLess", "10 Envelope", "DL envelope", "C5 Envelope"]
    var types: [String] = ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"]
    var quality: [String] = ["Automatic", "Normal", "Best", "Draft"]
    
    var copyColor: String?
    
   var color: [String] = ["Color", "Black and White"]
    
}

enum ScanQuality: Int {
    case Normal, Low, High
    
    func description() -> String{
        switch self {
        case .Normal:
            return "Normal"
        case .Low:
            return "Low(Fast)"
        case .High:
            return "High"
        }
        
    }
}
enum ScanColor:Int{
    case Color, GrayScale, BlackAndWhite
    func description()->String{
        switch self {
            
        case .Color:
            return "Color"
        case .GrayScale:
            return "Gray Scale"
        case .BlackAndWhite:
            return "Black and White"
        }
        
    }
    
}
enum ScanDocumentType: Int{
    case TextGraphics, Text
    func description() ->String {
        
        switch self {
        case .TextGraphics:
            return "Text and Graphics"
        case .Text:
            return "Text"
        }
    }
    
}
enum SaveAsType:Int {
    
    case Jpeg, Pdf
    
    func description() ->String{
        switch self {
        case .Jpeg:
            return "JPEG"
        case .Pdf:
            return "PDF"
        }
        
    }
}







