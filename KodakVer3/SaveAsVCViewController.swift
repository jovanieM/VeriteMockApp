//
//  SaveAsVCViewController.swift
//  KodakVer3
//
//  Created by jmolas on 4/17/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol SaveAsViewDelegate {
    func saveImage(name : String, ext : String)
}

class SaveAsVCViewController: UIViewController, UITextFieldDelegate {
    
    var delegate : SaveAsViewDelegate?
    var extName : String?

    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBAction func cancelAction(_ sender: UIButton) {
       self.dismiss(animated: false, completion: nil)
    }
  
    @IBAction func saveAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        let name = textField.text
        delegate?.saveImage(name: name!, ext : extName!)
        
    }
  
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let fGen = FileNameGenerator()
        
        textField.text = fGen.generateFileName()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String{
    func stringByRemovingAll(characters : [Character]) -> String{
        return String(self.characters.filter({
            !characters.contains($0)
        }))
        
    }

}


