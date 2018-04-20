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
var tagger: Int?

protocol loadData: class {
    func reloadData()
}

@available(iOS 9.0, *)
class PreviewViewController: UIViewController, AddressSizeViewDelegate {
    
    
    var addressSize = ["Large", "Normal", "Small"]
    var fontType = ["Times New Roman", "Arial", "Marker Felt", "Snell Roundhand"]
    
    var onOff = ["ON", "OFF"]
    
    @IBOutlet weak var returnName: UILabel!
    @IBOutlet weak var returnStreet: UILabel!
    @IBOutlet weak var returnAddress: UILabel!
    @IBOutlet weak var returnCountry: UILabel!
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityStatePostal: UILabel!
    @IBOutlet weak var addressStreet1: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var envelopeDescription: UILabel!
    @IBOutlet weak var envelopeName: UILabel!
    @IBOutlet weak var previewWindow: UIView!
    @IBOutlet weak var FontSettingView: UIView!
    @IBOutlet weak var fontsettingButton: UIButton!
    
    @IBOutlet weak var optionsettingButton: UIButton!
    @IBOutlet weak var OptionSettingView: UIView!
    
    let defaults = UserDefaults.standard
    let fnameKey = "firstname"
    let mnameKey = "middlename"
    let lnameKey = "lastname"
    let streetKey = "street"
    let cityKey = "city"
    let stateKey = "state"
    let postalCodeKey = "postalCode"
    let countryKey = "country"
    
    var size = [0, 0, 0, 0, 0]
    
    
    var nameReceived: String = ""
    var descReceived: String = ""
    var passedAddress: String = ""
    var passedName: String = ""
    var passedStreet: String = ""
    var passedCity: String = ""
    var passedState: String = ""
    var passedPostalCode: String = ""
    var passedCountry: String = ""
    
    var table:AddressSizeSettingsViewer!
    var contact: CNContactProperty = CNContactProperty()
    
    let tempImage = UIImage(named: "icon_env_photo.png")
    let pd = AddressPrintData()
    
    override func viewWillAppear(_ animated: Bool) {
        
        let first = defaults.object(forKey: fnameKey) as! String
        let middle = defaults.object(forKey: mnameKey) as! String?
        let last = defaults.object(forKey: lnameKey) as! String?
        let street = defaults.object(forKey: streetKey) as! String?
        let city = defaults.object(forKey: cityKey) as! String?
        let state = defaults.object(forKey: stateKey) as! String?
        let postal = defaults.object(forKey: postalCodeKey) as! String?
        let country = defaults.object(forKey: countryKey) as! String?
        
        print("\(first)")
        print("\(String(describing: middle))")
        print("\(last ?? "")")
        returnName.text = first + " " + middle! + " " + last!
        returnStreet.text = street!
        returnAddress.text = city! + " " + state! + " " + postal!
        returnCountry.text = country!

    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(String(describing: tagger))")
        
   //     pd.thumbNail = tempImage
        
//        defaults.set("", forKey: fnameKey)
//        defaults.set("", forKey: lnameKey)
//        defaults.set("", forKey: mnameKey)
//        defaults.set("", forKey: streetKey)
//        defaults.set("", forKey: cityKey)
//        defaults.set("", forKey: stateKey)
//        defaults.set("", forKey: postalCodeKey)
//        defaults.set("", forKey: countryKey)

        
        let screenwidth = self.view.frame.size.width
        let screenheight = self.view.frame.size.height
        
        envelopeDescription.text = descReceived
        envelopeName.text = nameReceived
        nameLabel.text = passedName
        addressStreet1.text = passedStreet
        cityStatePostal.text = passedCity + " " + passedState + " " + passedPostalCode
        countryLabel.text = passedCountry
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.sizeToFitHeight()
        addressStreet1.sizeToFitHeight()
        cityStatePostal.sizeToFitHeight()
        countryLabel.sizeToFitHeight()
        returnName.sizeToFitHeight()
        returnStreet.sizeToFitHeight()
        returnAddress.sizeToFitHeight()
        returnCountry.sizeToFitHeight()

        if tagger == 0 {
            returnName.isHidden = false
            returnStreet.isHidden = false
            returnAddress.isHidden = false
            returnCountry.isHidden = false
            size[3] = 0
        } else {
            returnName.isHidden = true
            returnStreet.isHidden = true
            returnAddress.isHidden = true
            returnCountry.isHidden = true
            size[3] = 1
        }

        
        
        if size[4] == 0 {
            
            returnName.font = returnName.font.withSize(6)
            returnStreet.font = returnStreet.font.withSize(6)
            returnAddress.font = returnAddress.font.withSize(6)
            returnCountry.font = returnCountry.font.withSize(6)


        }
        
        if envelopeName.text == "Photo" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((468*0.60)/2), y: (screenheight / 2) - ((342*0.60)/2) - 67, width: 468*0.60, height: 342*0.60)
            
            cityStatePostal.frame.origin.x = previewWindow.bounds.origin.x + 100
            cityStatePostal.frame.origin.y = previewWindow.frame.height - 50
            countryLabel.frame.origin.x = previewWindow.bounds.origin.x + 100
            countryLabel.frame.origin.y = cityStatePostal.frame.origin.y + cityStatePostal.frame.height
            addressStreet1.frame.origin.x = previewWindow.bounds.origin.x + 100
            addressStreet1.frame.origin.y = cityStatePostal.frame.origin.y - addressStreet1.frame.height
            nameLabel.frame.origin.x = previewWindow.bounds.origin.x + 100
            nameLabel.frame.origin.y = addressStreet1.frame.origin.y - nameLabel.frame.height
            
            returnName.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnName.frame.origin.y = previewWindow.bounds.origin.y + 5
            returnStreet.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnStreet.frame.origin.y = returnName.frame.origin.y + returnStreet.frame.height
            returnAddress.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnAddress.frame.origin.y = returnStreet.frame.origin.y + returnAddress.frame.height
            returnCountry.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnCountry.frame.origin.y = returnAddress.frame.origin.y + returnCountry.frame.height

            
        } else if envelopeName.text == "No. 6 3/4" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((468*0.60)/2), y: (screenheight / 2) - ((261*0.60)/2) - 67, width: 468*0.60, height: 261*0.60)
            
            cityStatePostal.frame.origin.x = previewWindow.bounds.origin.x + 100
            cityStatePostal.frame.origin.y = previewWindow.frame.height - 40
            countryLabel.frame.origin.x = previewWindow.bounds.origin.x + 100
            countryLabel.frame.origin.y = cityStatePostal.frame.origin.y + cityStatePostal.frame.height
            addressStreet1.frame.origin.x = previewWindow.bounds.origin.x + 100
            addressStreet1.frame.origin.y = cityStatePostal.frame.origin.y - addressStreet1.frame.height
            nameLabel.frame.origin.x = previewWindow.bounds.origin.x + 100
            nameLabel.frame.origin.y = addressStreet1.frame.origin.y - nameLabel.frame.height
            
            returnName.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnName.frame.origin.y = previewWindow.bounds.origin.y + 5
            returnStreet.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnStreet.frame.origin.y = returnName.frame.origin.y + returnStreet.frame.height
            returnAddress.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnAddress.frame.origin.y = returnStreet.frame.origin.y + returnAddress.frame.height
            returnCountry.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnCountry.frame.origin.y = returnAddress.frame.origin.y + returnCountry.frame.height


        } else if envelopeName.text == "No. 10" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((684*0.42)/2), y: (screenheight / 2) - ((297*0.42)/2) - 67, width: 684*0.42, height: 297*0.40)
            
            cityStatePostal.frame.origin.x = previewWindow.bounds.origin.x + 95
            cityStatePostal.frame.origin.y = previewWindow.frame.height - 40
            countryLabel.frame.origin.x = previewWindow.bounds.origin.x + 95
            countryLabel.frame.origin.y = cityStatePostal.frame.origin.y + cityStatePostal.frame.height
            addressStreet1.frame.origin.x = previewWindow.bounds.origin.x + 95
            addressStreet1.frame.origin.y = cityStatePostal.frame.origin.y - addressStreet1.frame.height
            nameLabel.frame.origin.x = previewWindow.bounds.origin.x + 95
            nameLabel.frame.origin.y = addressStreet1.frame.origin.y - nameLabel.frame.height
            
            returnName.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnName.frame.origin.y = previewWindow.bounds.origin.y + 5
            returnStreet.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnStreet.frame.origin.y = returnName.frame.origin.y + returnStreet.frame.height
            returnAddress.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnAddress.frame.origin.y = returnStreet.frame.origin.y + returnAddress.frame.height
            returnCountry.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnCountry.frame.origin.y = returnAddress.frame.origin.y + returnCountry.frame.height
            
        } else if envelopeName.text == "6x9" {
            previewWindow.frame = CGRect(x: (screenwidth / 2) - ((432*0.48)/2), y: (screenheight / 2) - ((648*0.48)/2) - 65, width: 432*0.48, height: 648*0.48)         
            
            cityStatePostal.frame.origin.x = previewWindow.bounds.origin.x + 45
            cityStatePostal.frame.origin.y = previewWindow.frame.height - 70
            countryLabel.frame.origin.x = previewWindow.bounds.origin.x + 45
            countryLabel.frame.origin.y = cityStatePostal.frame.origin.y + cityStatePostal.frame.height
            addressStreet1.frame.origin.x = previewWindow.bounds.origin.x + 45
            addressStreet1.frame.origin.y = cityStatePostal.frame.origin.y - addressStreet1.frame.height
            nameLabel.frame.origin.x = previewWindow.bounds.origin.x + 45
            nameLabel.frame.origin.y = addressStreet1.frame.origin.y - nameLabel.frame.height

            
            returnName.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnName.frame.origin.y = previewWindow.bounds.origin.y + 5
            returnStreet.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnStreet.frame.origin.y = returnName.frame.origin.y + returnStreet.frame.height
            returnAddress.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnAddress.frame.origin.y = returnStreet.frame.origin.y + returnAddress.frame.height
            returnCountry.frame.origin.x = previewWindow.bounds.origin.x + 5
            returnCountry.frame.origin.y = returnAddress.frame.origin.y + returnCountry.frame.height


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
            countryOnOff()
        } else if receiver == 3 {
             size[3] = index
            tagger = index
            displayReturnAdd()
        } else if receiver == 4 {
            size[4] = index
            returnAddSize()
        }
        
        nameLabel.sizeToFitHeight()
        addressStreet1.sizeToFitHeight()
//        addressStreet2.sizeToFitHeight()
        cityStatePostal.sizeToFitHeight()
        countryLabel.sizeToFitHeight()
        returnName.sizeToFitHeight()
        returnStreet.sizeToFitHeight()
        returnAddress.sizeToFitHeight()
        returnCountry.sizeToFitHeight()
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
        
        table.propertyIndex = 4
        table.preselect = size[4]
        table.data = addressSize
        
        table.sendAddressPrintDelegate = self
        
        self.view.window?.addSubview(table)
    }
   
    
    @IBAction func selectAddressSize(_ sender: Any) {
        
        table  = AddressSizeSettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        
        table.propertyIndex = 0
        table.preselect = size[0]
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
    
    
//    
    
//    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    @IBAction func toPrintQueue(_ sender: Any) {
        pd.thumbNail = tempImage
        let NextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressPrintQueueViewController") as? AddressPrintQueueViewController
        NextViewController?.printData = [pd]
        self.navigationController?.pushViewController(NextViewController!, animated: true)
        
        }
    
    
    
    func applySize(){
        
        switch size[0] {
        case 0:
            nameLabel.font = nameLabel.font.withSize(8)
            addressStreet1.font = addressStreet1.font.withSize(8)
            cityStatePostal.font = addressStreet1.font.withSize(8)
            countryLabel.font = addressStreet1.font.withSize(8)
            
        case 1:
            nameLabel.font = nameLabel.font.withSize(7)
            addressStreet1.font = addressStreet1.font.withSize(7)
            cityStatePostal.font = addressStreet1.font.withSize(7)
            countryLabel.font = addressStreet1.font.withSize(7)
        
        case 2:
            nameLabel.font = nameLabel.font.withSize(6)
            addressStreet1.font = addressStreet1.font.withSize(6)
            cityStatePostal.font = addressStreet1.font.withSize(6)
            countryLabel.font = addressStreet1.font.withSize(6)
            
        default:
            break
        }

    }
    
    
    func returnAddSize() {
        switch size[4] {
        case 0:
            returnName.font = returnName.font.withSize(6)
            returnStreet.font = returnStreet.font.withSize(6)
            returnAddress.font = returnAddress.font.withSize(6)
            returnCountry.font = returnCountry.font.withSize(6)
        case 1:
            returnName.font = returnName.font.withSize(5)
            returnStreet.font = returnStreet.font.withSize(5)
            returnAddress.font = returnAddress.font.withSize(5)
            returnCountry.font = returnCountry.font.withSize(5)
        case 2:
            returnName.font = returnName.font.withSize(4)
            returnStreet.font = returnStreet.font.withSize(4)
            returnAddress.font = returnAddress.font.withSize(4)
            returnCountry.font = returnCountry.font.withSize(4)
        default:
            break
        }
    }
    
    
    func applyFont(){
        
        let namesize = self.nameLabel.font.pointSize
        let addsize = self.addressStreet1.font.pointSize
        let returnsize = self.returnName.font.pointSize
        
        switch size[1] {
        case 0:
            nameLabel.font = UIFont(name: "Times New Roman", size: namesize)
            addressStreet1.font = UIFont(name: "Times New Roman", size: addsize)
            cityStatePostal.font = UIFont(name: "Times New Roman", size: addsize)
            countryLabel.font = UIFont(name: "Times New Roman", size: addsize)
            returnName.font = UIFont(name: "Times New Roman", size: returnsize)
            returnStreet.font = UIFont(name: "Times New Roman", size: returnsize)
            returnAddress.font = UIFont(name: "Times New Roman", size: returnsize)
            returnCountry.font = UIFont(name: "Times New Roman", size: returnsize)
            print("timesNewRoman")
        case 1:
            nameLabel.font = UIFont(name: "Arial", size: namesize)
            addressStreet1.font = UIFont(name: "Arial", size: addsize)
            cityStatePostal.font = UIFont(name: "Arial", size: addsize)
            countryLabel.font = UIFont(name: "Arial", size: addsize)
            returnName.font = UIFont(name: "Arial", size: returnsize)
            returnStreet.font = UIFont(name: "Arial", size: returnsize)
            returnAddress.font = UIFont(name: "Arial", size: returnsize)
            returnCountry.font = UIFont(name: "Arial", size: returnsize)
        case 2:
            nameLabel.font = UIFont(name: "Marker Felt", size: namesize)
            addressStreet1.font = UIFont(name: "Marker Felt", size: addsize)
            cityStatePostal.font = UIFont(name: "Marker Felt", size: addsize)
            countryLabel.font = UIFont(name: "Marker Felt", size: addsize)
            returnName.font = UIFont(name: "Marker Felt", size: returnsize)
            returnStreet.font = UIFont(name: "Marker Felt", size: returnsize)
            returnAddress.font = UIFont(name: "Marker Felt", size: returnsize)
            returnCountry.font = UIFont(name: "Marker Felt", size: returnsize)
            
        case 3:
            nameLabel.font = UIFont(name: "Snell Roundhand", size: namesize)
            addressStreet1.font = UIFont(name: "Snell Roundhand", size: addsize)
            cityStatePostal.font = UIFont(name: "Snell Roundhand", size: addsize)
            countryLabel.font = UIFont(name: "Snell Roundhand", size: addsize)
            returnName.font = UIFont(name: "Snell Roundhand", size: returnsize)
            returnStreet.font = UIFont(name: "Snell Roundhand", size: returnsize)
            returnAddress.font = UIFont(name: "Snell Roundhand", size: returnsize)
            returnCountry.font = UIFont(name: "Snell Roundhand", size: returnsize)
        default: break
        }
    }
    
    
    func displayReturnAdd() {
        
        if size[3] == 0 {
            returnName.isHidden = false
            returnStreet.isHidden = false
            returnAddress.isHidden = false
            returnCountry.isHidden = false
            
        } else {
            returnName.isHidden = true
            returnStreet.isHidden = true
            returnAddress.isHidden = true
            returnCountry.isHidden = true
        }
    }
    
    func countryOnOff(){
        
        switch size[2] {
        case 0:
            if returnName.isHidden == true {
                countryLabel.isHidden = false
                returnCountry.isHidden = true
            } else if returnName.isHidden == false {
            countryLabel.isHidden = false
            returnCountry.isHidden = false
            }
        case 1:
            countryLabel.isHidden = true
            returnCountry.isHidden = true
        default:
            break
        }
    }

    
    
}

extension UILabel{
    func sizeToFitHeight() {
        let size: CGSize = self.sizeThatFits(CGSize.init(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        var frame:CGRect = self.frame
        frame.size.height = size.height
        self.frame = frame
        
    }
}
