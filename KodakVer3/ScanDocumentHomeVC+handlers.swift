//
//  ScanDocumentHomeVC+handlers.swift
//  KodakVer3
//
//  Created by jmolas on 4/17/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

extension ScanDocumentHomeVC{
    
  

    func save(filename: String, fileExt : String){
        
        
        let fileURL = createLocalURL(forImageNamed: filename, forUIImage: imageView.image!, ext: fileExt)
        documentController = UIDocumentInteractionController.init(url: fileURL!)
        
        documentController.presentOpenInMenu(from: self.cropButton.frame, in: self.view, animated: true)
    
    
    }
    func createLocalURL(forImageNamed name : String, forUIImage uiImage : UIImage, ext: String) -> URL?{
        
        let fileMngr = FileManager.default
        let cacheDir = fileMngr.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDir.appendingPathComponent("\(name).\(ext)")
        let path = url.path
        
        if let data = UIImagePNGRepresentation(uiImage){
            
            fileMngr.createFile(atPath: path, contents: data, attributes: nil)
            return url
            
        }
 
        //        guard  fileMngr.fileExists(atPath: path) else {
        //            guard let image = convertedImage[0],
        //                let data = UIImagePNGRepresentation(image)
        //
        //                else {
        //                return nil
        //            }
        //            fileMngr.createFile(atPath: path, contents: data, attributes: nil)
        //            return url
        //        }
        return nil
    }
    
    func openCloseTray(open : Bool){
        
        if open{
            // tray is currently open
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonContainer.center.y = self.buttonContainer.center.y + self.buttonContainer.frame.height
                self.buttonNext.isUserInteractionEnabled = true
                self.isTrayOpen = false
            }) { (done) in
                if done{
                    self.sendIcon.isHighlighted = false
                }
            }
    
        }else{
            // tray is currently close
            
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonContainer.center.y = self.buttonContainer.center.y - self.buttonContainer.frame.height
                self.buttonNext.isUserInteractionEnabled = false
                self.isTrayOpen = true
            }) { (done) in
                if done{
                    self.sendIcon.isHighlighted = true
                }
            }
            
        }
        
    }

}
