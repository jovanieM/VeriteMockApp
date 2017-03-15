//
//  CustomCopyViewController.swift
//  KodakVer3
//
//  Created by SQA on 23/02/2017.
//  Copyright © 2017 mmolo. All rights reserved.
//

import UIKit

class CustomCopyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingViewDelegate, PagesPerSideDelegate {

    @IBOutlet weak var customcopybutton: UIButton!
    
    var arrayofMainLbl = ["Color :", "Paper Size :",  "Paper Type :", "Print Quality :", "Copy Resize :", "Pages per Side :", "Brightness :"]
    
    var collections: [[String]] = [["Color", "Black and White"], ["4x6 in.", "3x5 in", "5x7 in.", "3.5x5 in.(L)", "Letter", "Legal", "Executive", "Statement", "A4", "JIS B5", "A5", "A6", "Hagaki", "10 Envelope", "DL envelope", "C5 Envelope"],   ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"], ["Automatic", "Normal", "Best", "Draft"], ["100% Default", "130% Letter->Legal", "104% Executive->Letter", "97% Letter->A4", "93% A4->Letter", "85% Letter->Executive", "Custom"], ["One", "2 in 1 Portrait", "2 in 1 Landscape", "4 in 1 Portrait", "4 in 1 Landscape"], ["dummybrightness"]]

    
    
    var perSideArrays: [(String, String)] = [("One", "one.png"), ("2 in 1 Portrait", "two_portrait.png"), ("2 in 1 Landscape", "two_landscape.png"), ("4 in 1 Portrait", "four_portrait.png"), ("4 in 1 Landscape", "four_landscape.png")]
    
    
    @IBOutlet weak var customTable: UITableView!
    
    
    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 1.0
    private let paperSizeKey: String = "size"
    private let colorOutKey: String = "color"
    private let typeKey: String = "type"
    private let qualityKey: String = "quality"
    private let resizeKey: String = "resize"
    private let pagespersideKey: String = "pagesperside"
    
    
    var table:SettingsViewer!
    var table2:PagesPerSideViewer!
        
    let defaultSize = UserDefaults.standard
    let defaultColor = UserDefaults.standard
    let defaultType = UserDefaults.standard
    let defaultQuality = UserDefaults.standard
    let defaultResize = UserDefaults.standard
    let defaultPerSide = UserDefaults.standard
       
    @IBOutlet weak var customcopyTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customcopybutton.layer.cornerRadius = 15;
        customcopybutton.layer.borderWidth = 1;
        customcopybutton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        customcopybutton.layer.masksToBounds = true;
        
        
        customTable.delegate = self
        customTable.dataSource = self
        
        customTable.backgroundColor = .black
        customTable.tableFooterView = UIView(frame: .zero)
        customTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: customTable.frame.width, height: kSeparatorHeight))
        customTable.tableHeaderView?.backgroundColor = .lightGray
        
        
        
    }

    @IBAction func customcopybuttonPressed(_ sender: Any) {
        
      		
        
        let alert = UIAlertController(title: nil, message: "Copying... \n", preferredStyle: .alert)
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 60, width: 40, height:40))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        indicator.activityIndicatorViewStyle = .gray
        
        alert.view.addSubview(indicator)
        indicator.startAnimating()
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
            let alert2 = UIAlertController(title: nil, message: "Copy canceled", preferredStyle: .alert)
            let OKAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert2.addAction(OKAction2)
            self.present(alert2, animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 4.0
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }

    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.viewWithTag(kSeparatorID) == nil
        {
            let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.height - kSeparatorHeight , width: cell.frame.width, height: kSeparatorHeight))
            separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            separatorView.backgroundColor = .lightGray
            cell.addSubview(separatorView)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
        
    }
    
    // display the corresponding custom copy settings table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if indexPath.row == 6 {
        
            let cell = Bundle.main.loadNibNamed("BrightnessTableViewCell", owner: self, options: nil)?.first as! BrightnessTableViewCell
        //cell.brightnessbar.isContinuous = true
        cell.brightnessbar.setThumbImage(UIImage(named: "seekbar_thumb"), for: .normal)
        
        cell.selectionStyle = .none
            return cell
          }
            
        else{
        
            let cell2 = Bundle.main.loadNibNamed("CustomCopySecondCell", owner: self, options: nil)?.first as! CustomCopySecondCell
            cell2.settingname.adjustsFontSizeToFitWidth = true
            cell2.settingname.text = arrayofMainLbl[indexPath.row]
            cell2.selectedsetting.text = collections[indexPath.row][getSavedData(receiver: indexPath.row)]
            
            return cell2
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    //display the corresponding tableview based on the selected custom copy settings
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        if indexPath.row <= 4{
            
            
            table  = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            table.propertyIndex = indexPath
            table.data = collections[indexPath.row]
            
            
            self.view.window?.addSubview(table)
            table.sendDataDelegate = self
            tableView.deselectRow(at: indexPath, animated: false)
            
        } else if indexPath.row == 5{
            
            
            table2  = PagesPerSideViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            
            table2.propertyIndex = indexPath
            table2.data = perSideArrays
            
            self.view.window?.addSubview(table2)
            table2.sendDataDelegate = self
            tableView.deselectRow(at: indexPath, animated: false)
            

        }

        
    }
    
    
    func computeHeight(numberOfItems: Int) ->Int{
        if numberOfItems > 5 {
            let height = UIScreen.main.bounds.height * 0.8
            return Int(height / 44.0)
        }else{
            return numberOfItems
        }
    }
    func getSavedData(receiver: Int) -> Int{
        
        switch receiver {
        case 1:
            return defaultSize.integer(forKey: paperSizeKey)
        case 2:
            return defaultColor.integer(forKey: colorOutKey)
        case 3:
            return defaultType.integer(forKey: typeKey)
        case 4:
            return defaultQuality.integer(forKey: qualityKey)
        case 5:
            return defaultResize.integer(forKey: resizeKey)
        case 6:
            return defaultPerSide.integer(forKey: pagespersideKey)
        default:
            return 0
        }
        
    }
    func setData(value: Int, receiverIndex: Int){
        switch receiverIndex {
        case 1:
            defaultSize.set(value, forKey: paperSizeKey)
        case 2:
            defaultColor.set(value, forKey: colorOutKey)
        case 3:
            defaultType.set(value, forKey: typeKey)
        case 4:
            defaultQuality.set(value, forKey: qualityKey)
        case 5:
            defaultResize.set(value, forKey: resizeKey)
        case 5:
            defaultPerSide.set(value, forKey: pagespersideKey)
        default:
            break
        }
    }
    
    func sendData(index: Int, receiver: IndexPath) {
        
        setData(value: index, receiverIndex: receiver.row)
        
        
        let cell = self.customTable.cellForRow(at: receiver) as! CustomCopySecondCell
        
        cell.selectedsetting.text = collections[receiver.row][getSavedData(receiver: receiver.row)]
    }

    
    
    
    
    
    
   
}
