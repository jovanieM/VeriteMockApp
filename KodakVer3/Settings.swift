//
//  Settings.swift
//  KodakVer3
//
//  Created by jmolas on 3/22/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import Foundation

enum Settings: Int{
   
    case Psizes
    case Coutput
    case PTypes
    case PQuality
    
    
    
    enum PaperSizes: Int{
        case PostCard
        case PostCardBorderless
        case IndexCard
        case Size2L
        case Size2LBorderless
        case SizeL
        case SizeLBorderless
        case Letter
        case LetterBorderless
        case Legal
        case Executive
        case Statement
        case A4
        case A4Borderless
        case JISB5
        case A5
        case A5Borderless
        case A6
        case A6Borderless
        case Hagaki
        case HagakiBorderless
        case Env10
        case EnvDL
        case EnvC5
        
        func description() -> String{
            switch self {
            case .PostCard:
                return "4x6 in."
            case .PostCardBorderless:
                return "4x6 in. Borderless"
            case .IndexCard:
                return "3x5 in."
            case .Size2L:
                return "5x7 in."
            case .Size2LBorderless:
                return "5x7 in. Borderless"
            case .SizeL:
                return "3.5x5 in."
            case .SizeLBorderless:
                return "3.5x5 in. Boderless"
            case .Letter:
                return "Letter"
            case .LetterBorderless:
                return "Letter Borderless"
            case .Legal:
                return "Legal"
            case .Executive:
                return "Executive"
            case .Statement:
                return "Statement"
            case .A4:
                return "A4"
            case .A4Borderless:
                return "A4 Borderless"
            case .JISB5:
                return "JIS B5"
            case .A5:
                return "A5"
            case .A5Borderless:
                return "A5 Borderless"
            case .A6:
                return "A6"
            case .A6Borderless:
                return "A6 Borderless"
            case .Hagaki:
                return "Hagaki"
            case .HagakiBorderless:
                return "Hagaki Borderless"
            case .Env10:
                return "10 Envelope"
            case .EnvDL:
                return "DL Envelope"
            case .EnvC5:
                return "C5 Envelope"
            
            }
        
        }
    
    }
    enum ColorOutput{
        case Color
    }
    enum PaperTypes{
        case Plain
        case Labels
        case Envelope
        case GlossyPhoto
        case MattePhoto
        
        func description() -> String{
            switch self {
            case .Plain:
                return "Plain"
            case .Labels:
                return "Labels"
            case .Envelope:
                return "Envelope"
            case .GlossyPhoto:
                return "GlossyPhoto"
            case .MattePhoto:
                return "Matte Photo"
                
            }
        }
        
    }
    
    enum PrintQuality {
        case Automatic
        case Normal
        case Best
        case Draft
        
        func description()->String{
            switch self {
            case .Automatic:
                return "Automatic"
            case .Normal:
                return "Normal"
            case .Best:
                return "Best"
            case .Draft:
                return "Draft"
            
            }
            
        }
    }
    

    
//    var paperSizes : PaperSizes
//    var paperTypes : PaperTypes
//    var colorOutput : ColorOutput
//    var printQuality : PrintQuality
    

}
