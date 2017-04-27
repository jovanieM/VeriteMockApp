//
//  PreviewViewController.swift
//  KodakVer3
//
//  Created by SQA on 31/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


protocol loadData: class {
    func reloadData()
}

@available(iOS 9.0, *)
class PreviewViewController: UIViewController, AddressSizeViewDelegate {
    
    var size = [0, 0, 0, 0, 0]
    var addressSize = ["Large", "Normal", "Small"]
    var fontType = ["Times New Roman", "Arial", "Marker Felt", "Snell Roundhand"]
    
    var onOff = ["ON", "OFF"]
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var envelopeDescription: UILabel!
    @IBOutlet weak var envelopeName: UILabel!
    @IBOutlet weak var previewWindow: UIView!
    @IBOutlet weak var FontSettingView: UIView!
    @IBOutlet weak var fontsettingButton: UIButton!
    
    @IBOutlet weak var optionsettingButton: UIButton!
    @IBOutlet weak var OptionSettingView: UIView!
    
    var nameReceived: String = ""
    var descReceived: String = ""
    var passedAddress: String = ""
    var passedName: String = ""
    
    var table:AddressSizeSettingsViewer!
    var contact: CNContactProperty = CNContactProperty()
    
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      let times = [NSFontAttributeName: UIFont.fontNames(forFamilyName: "Times New Roman")]
//      let datas = NSMutableAttributedString(string: "Times New Roman", attributes: times)
   
        let screenwidth = self.view.frame.size.width
        let screenheight = self.view.frame.size.height
        
//      fontType.append(timesType)
//      fontType.append(arialType as! NSMutableAttributedString)
        
        envelopeDescription.text = descReceived
        envelopeName.text = nameReceived
        self.addressLabel.text = passedAddress
        self.nameLabel.text = passedName
        addressLabel.adjustsFontSizeToFitWidth = true
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.sizeToFitHeight()
        addressLabel.sizeToFitHeight()
        
        
        
        if envelopeName.text == "Photo" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((468*0.60)/2), y: (screenheight / 2) - ((342*0.60)/2) - 67, width: 468*0.60, height: 342*0.60)
            addressLabel.frame.origin.x = previewWindow.center.x - 60
            addressLabel.frame.origin.y = (previewWindow.frame.height - addressLabel.frame.height) - 30
            nameLabel.frame.origin.x = previewWindow.center.x - 60
            nameLabel.frame.origin.y = addressLabel.frame.origin.y - nameLabel.frame.height
            
        } else if envelopeName.text == "No. 6 3/4" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((468*0.60)/2), y: (screenheight / 2) - ((261*0.60)/2) - 67, width: 468*0.60, height: 261*0.60)
            addressLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            addressLabel.frame.origin.y = previewWindow.frame.height - (addressLabel.frame.height) - 20
            nameLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            nameLabel.frame.origin.y = addressLabel.frame.origin.y - nameLabel.frame.height

        } else if envelopeName.text == "No. 10" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((684*0.42)/2), y: (screenheight / 2) - ((297*0.42)/2) - 67, width: 684*0.42, height: 297*0.40)
            addressLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            addressLabel.frame.origin.y = previewWindow.frame.height - (addressLabel.frame.height) - 15
            nameLabel.frame.origin.x = previewWindow.frame.origin.x + 80
            nameLabel.frame.origin.y = addressLabel.frame.origin.y - nameLabel.frame.height
            
        } else {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((432*0.48)/2), y: (screenheight / 2) - ((648*0.48)/2) - 67, width: 432*0.48, height: 648*0.48)
            addressLabel.frame.origin.x = previewWindow.frame.origin.x - 10
            addressLabel.frame.origin.y = (previewWindow.frame.height - addressLabel.frame.height) - 50
            nameLabel.frame.origin.x = previewWindow.frame.origin.x - 10
            nameLabel.frame.origin.y = addressLabel.frame.origin.y - nameLabel.frame.height
        }
        
    
    }
    
    
    func sendAddressPrintData(index: Int, receiver: Int) {
        
        if receiver == 0 {
            size[0] = index
            applySize()
            print(index)
        } else if receiver == 1 {
            size[1] = index
            applyFont()
            print(index)
        } else if receiver == 2 {
            size[2] = index
        } else if receiver == 3 {
            size[3] = index
        } else if receiver == 4 {
            size[4] = index
        }
        
        nameLabel.sizeToFitHeight()
        addressLabel.sizeToFitHeight()
        viewDidLoad()
     }

    
    
    @IBAction func fontSettingButton(_ sender: UIButton) {
        
   
        if !fontsettingButton.isSelected {
            closeOptionSettingView()
            openFontSettingView()
            
            NSLog("open")
        } else  {
            NSLog("close")
            closeFontSettingView()
        }
        
    }
    
    func openFontSettingView(){
        UIView.animate(withDuration: 0.5, animations: { self.FontSettingView.frame.origin.y = self.fontsettingButton.frame.origin.y - self.FontSettingView.frame.height  })
        fontsettingButton.isSelected = true
    }
    
    func closeFontSettingView(){
        UIView.animate(withDuration: 0.5, animations: { self.FontSettingView.frame.origin.y = self.fontsettingButton.frame.origin.y + self.FontSettingView.frame.height  })
        fontsettingButton.isSelected = false
    }
    
    
    @IBAction func optionSettingButton(_ sender: Any) {
        
        if !optionsettingButton.isSelected{
            openOptionSettingView()
            closeFontSettingView()
            
        } else{
            closeOptionSettingView()
            
        }
    }
    
    func openOptionSettingView(){
        UIView.animate(withDuration: 0.5, animations: { self.OptionSettingView.frame.origin.y = self.optionsettingButton.frame.origin.y - self.OptionSettingView.frame.height  })
        optionsettingButton.isSelected = true
        
    }
    
    func closeOptionSettingView(){
        UIView.animate(withDuration: 0.5, animations: { self.OptionSettingView.frame.origin.y = self.optionsettingButton.frame.origin.y + self.OptionSettingView.frame.height  })
        optionsettingButton.isSelected = false
        
    }
    
    @IBAction func retAddSize(_ sender: Any) {
        
        table  = AddressSizeSettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        
        table.preselect = size[4]
        table.propertyIndex = 4
        table.data = addressSize
        
        table.sendAddressPrintDelegate = self
        
        self.view.window?.addSubview(table)
    }
   
    
    @IBAction func selectAddressSize(_ sender: Any) {
        
        table  = AddressSizeSettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        
        table.preselect = size[0]
        table.propertyIndex = 0
        table.data = addressSize
        
        
        table.sendAddressPrintDelegate = self
        
        self.view.window?.addSubview(table)
    
    }
    
    
    @IBAction func selectFontType(_ sender: Any) {
        
        table  = AddressSizeSettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        table.propertyIndex = 1
        table.preselect = size[1]
        
        table.data = fontType
      //  table.dataNS = fontType
        table.sendAddressPrintDelegate = self
        //    tableView.deselectRow(at: indexPath, animated: false)
        self.view.window?.addSubview(table)
    }
    
    
    @IBAction func displayCountry(_ sender: Any) {
        
        table  = AddressSizeSettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        
        table.propertyIndex = 2
        table.preselect = size[2]
        table.data = onOff
        
        table.sendAddressPrintDelegate = self
        //    tableView.deselectRow(at: indexPath, animated: false)
        self.view.window?.addSubview(table)
        
    }
    
    @IBAction func displayReturnAdd(_ sender: Any) {
        
        table  = AddressSizeSettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        
        table.propertyIndex = 3
        table.preselect = size[3]
        table.data = onOff
        
        table.sendAddressPrintDelegate = self
        //    tableView.deselectRow(at: indexPath, animated: false)
        self.view.window?.addSubview(table)
    }
    
    @IBAction func modifyReturnAdd(_ sender: Any) {
        
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReturnAddressViewController") as? ReturnAddressViewController
        self.navigationController?.pushViewController(NextViewController!, animated: true)
    }
    
    func applySize(){
        
        switch size[0] {
        case 0:
            nameLabel.font = nameLabel.font.withSize(8)
            addressLabel.font = addressLabel.font.withSize(8)
        case 1:
            nameLabel.font = nameLabel.font.withSize(7)
            addressLabel.font = addressLabel.font.withSize(7)
        case 2:
            nameLabel.font = nameLabel.font.withSize(6)
            addressLabel.font = addressLabel.font.withSize(6)
        default:
            break
        }
        

    }
    
    
    func applyFont(){
        
        let namesize = self.nameLabel.font.pointSize
        let addsize = self.addressLabel.font.pointSize
        
        switch size[1] {
        case 0:
            nameLabel.font = UIFont(name: "Times New Roman", size: namesize)
            addressLabel.font = UIFont(name: "Times New Roman", size: addsize)
            print("timesNewRoman")
        case 1:
            nameLabel.font = UIFont(name: "Arial", size: namesize)
            addressLabel.font = UIFont(name: "Arial", size: addsize)
        case 2:
            nameLabel.font = UIFont(name: "Marker Felt", size: namesize)
            addressLabel.font = UIFont(name: "Marker Felt", size: addsize)
        case 3:
            nameLabel.font = UIFont(name: "Snell Roundhand", size: namesize)
            addressLabel.font = UIFont(name: "Snell Roundhand", size: addsize)
        default: break
        }
    }
    
//    func countryOnOff(){
//        
//        switch size[2] {
//        case 0:
//            
//        default:
//            <#code#>
//        }
//    }

    
    
}

extension UILabel{
    func sizeToFitHeight() {
        let size: CGSize = self.sizeThatFits(CGSize.init(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        var frame:CGRect = self.frame
        frame.size.height = size.height
        self.frame = frame
        
    }
}
