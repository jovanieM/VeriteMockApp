//
//  DetailViewController.swift
//  KodakVer3
//
//  Created by jmolas on 12/8/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit




class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingViewDelegate{
    
    var arrayofMainLbl = ["dummy", "Paper Size :", "Color Output :", "Paper Type :", "Print Quality :"]

    var collections: [[String]] = [["dummy"],["4x6 in.", "4x6 in. Borderless", "3x5 in", "5x7 in.", "5x7 in. Borderless", "3.5x5 in.(L)", "3.5x5 in.(L) Borderless", "Letter", "Letter Borderless", "Legal", "Executive", "Statement", "A4", "A4 Borderless", "JIS B5", "A5", "A5 Borderless", "A6", "A6 Borderless", "Hagaki", "Hagaki BorderLess", "10 Envelope", "DL envelope", "C5 Envelope"],  ["Color"], ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"], ["Automatic", "Normal", "Best", "Draft"]]
    
   
    

    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 1.5
    private let paperSizeKey: String = "size"
    private let colorOutKey: String = "color"
    private let typeKey: String = "type"
    private let qualityKey: String = "quality"

    
    var table:SettingsViewer!
    
    let defaultSize = UserDefaults.standard
    let defaultColor = UserDefaults.standard
    let defaultType = UserDefaults.standard
    let defaultQuality = UserDefaults.standard
    
    @IBOutlet weak var detailSettings: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailSettings.delegate = self
        detailSettings.dataSource = self
        
        detailSettings.backgroundColor = .black
        detailSettings.tableFooterView = UIView(frame: .zero)
        detailSettings.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: detailSettings.frame.width, height: kSeparatorHeight))
        detailSettings.tableHeaderView?.backgroundColor = .lightGray
//      detailSettings.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)

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
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        if indexPath.row == 0 {
           
//          
            
            let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
            
            
            cell.numberOfCopies.text = Int(cell.copiesStepper.value).description
            cell.selectionStyle = .none
            
            return cell
            
//            let cell = FirstCell()
//            cell.numberOfCopies.text = Int(cell.copySetter.value).description
//            cell.selectionStyle = .none
//            return cell
            
            
        }else{
            
            let cell2 = Bundle.main.loadNibNamed("TableViewCell2", owner: self, options: nil)?.first as! TableViewCell2
            cell2.mainLabel.adjustsFontSizeToFitWidth = true
            cell2.mainLabel.text = arrayofMainLbl[indexPath.row]
            cell2.selectionLabel.text = collections[indexPath.row][getSavedData(receiver: indexPath.row)]
                      
            return cell2
        }
        
    }

  
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if tableView.tag != 99{
            
            if indexPath.row == 0{
                return UIScreen.main.bounds.height * 0.11111
            }else{
                return UIScreen.main.bounds.height * 0.0778
            }
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        indxpath = tableView.indexPathForSelectedRow!
        if indexPath.row != 0{
        
            
           table  = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            table.propertyIndex = indexPath
            table.data = collections[indexPath.row]
            
            
            //setData(value: 0, receiverIndex: indexPath.row - 1)
            self.view.window?.addSubview(table)
            table.sendDataDelegate = self
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
        
       
        let cell = self.detailSettings.cellForRow(at: receiver) as! TableViewCell2
     
        cell.selectionLabel.text = collections[receiver.row][getSavedData(receiver: receiver.row)]
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


