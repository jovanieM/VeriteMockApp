//
//  CustomCopyViewController.swift
//  KodakVer3
//
//  Created by SQA on 23/02/2017.
//  Copyright © 2017 mmolo. All rights reserved.
//

import UIKit

class CustomCopyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingViewDelegate {

    @IBOutlet weak var customcopybutton: UIButton!
    
    var arrayofMainLbl = ["Color :", "Paper Size :",  "Paper Type :", "Print Quality :"]
    
    var collections: [[String]] = [["Color", "Black and White"], ["4x6 in.", "3x5 in", "5x7 in.", "3.5x5 in.(L)", "Letter", "Legal", "Executive", "Statement", "A4", "JIS B5", "A5", "A6", "Hagaki", "10 Envelope", "DL envelope", "C5 Envelope"],   ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"], ["Automatic", "Normal", "Best", "Draft"]]
    
    
    @IBOutlet weak var customTable: UITableView!
    
    
    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 1.0
    private let paperSizeKey: String = "size"
    private let colorOutKey: String = "color"
    private let typeKey: String = "type"
    private let qualityKey: String = "quality"
    
    
    var table:SettingsViewer!
    
    let defaultSize = UserDefaults.standard
    let defaultColor = UserDefaults.standard
    let defaultType = UserDefaults.standard
    let defaultQuality = UserDefaults.standard
    
       
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
        
        let alert: UIAlertView = UIAlertView(title: nil, message: "Copying...", delegate: self, cancelButtonTitle: "Cancel");
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame:CGRect(x:95, y:90, width:40, height:40)) as UIActivityIndicatorView
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.setValue(loadingIndicator, forKey: "accessoryView");
        alert.show();
        
        
        
        
        //     let alertnext: UIAlertView = UIAlertView(title: nil, message: "Copy Canceled.", delegate: self, cancelButtonTitle: "OK");
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(withClickedButtonIndex:-1, animated: true)
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
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
//        if indexPath.row == 0 {
//            
//            //
//            
//            let cell = Bundle.main.loadNibNamed("CustomCopyFirstCell", owner: self, options: nil)?.first as! CustomCopyFirstCell
//            
////            
////            cell.numberOfCopies.text = Int(cell.copiesStepper.value).description
////            cell.selectionStyle = .none
//            
//            return cell
//            
//            //            let cell = FirstCell()
//            //            cell.numberOfCopies.text = Int(cell.copySetter.value).description
//            //            cell.selectionStyle = .none
//            //            return cell
//            
//            
//        }else{
        
            let cell2 = Bundle.main.loadNibNamed("CustomCopySecondCell", owner: self, options: nil)?.first as! CustomCopySecondCell
            cell2.settingname.adjustsFontSizeToFitWidth = true
            cell2.settingname.text = arrayofMainLbl[indexPath.row]
            cell2.selectedsetting.text = collections[indexPath.row][getSavedData(receiver: indexPath.row)]
            
            return cell2
//        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
   //     if tableView.tag != 99{
            
   //         if indexPath.row == 0{
   //             return UIScreen.main.bounds.height * 0.11111
   //         }else{
                return UIScreen.main.bounds.height * 0.0778
            }
   //     }
   //     return 44
  //  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
   //     if indexPath.row != 0{
            
            
            table  = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            table.propertyIndex = indexPath
            table.data = collections[indexPath.row]
            
            
            self.view.window?.addSubview(table)
            table.sendDataDelegate = self
            tableView.deselectRow(at: indexPath, animated: false)
            
   //     }
        
        
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
