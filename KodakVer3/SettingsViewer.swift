//
//  SettingsViewer.swift
//  KodakVer3
//
//  Created by jmolas on 1/12/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

//provides the newly selected index to the DetailviewController
protocol SettingViewDelegate {
    func sendData(index: Int, receiver: IndexPath)
}

class SettingsViewer: UIView, UITableViewDelegate, UITableViewDataSource{
    
    
    
    var sendDataDelegate: SettingViewDelegate?
    var width: CGFloat!
    var preselect:IndexPath?
    
    
    
    //creates a tableView for list of settings once tha data has been set
    var data: [String] = []{
        didSet{
            let tableView:UITableView = UITableView()
            tableView.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat(computeHeight(numberOfItems: data.count)) * 44.0)
            
            let detail: PrintPhotoVC = PrintPhotoVC()
            
            let index: Int = detail.getSavedData(receiver: propertyIndex!.row) ?? 0
            
            tableView.center = convert(center, from: self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.selectRow(at: IndexPath.init(row: index, section: 0), animated: false, scrollPosition: .middle)
            self.addSubview(tableView)

            
        }
    }
    
    var propertyIndex: IndexPath?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        width = frame.width
        self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
    
    }
    
    func computeHeight(numberOfItems: Int) ->Int{
        if numberOfItems > 5 {
            let height = UIScreen.main.bounds.height * 0.7
            return Int(height / 44.0)
        }else{
            return numberOfItems
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        sendDataDelegate?.sendData(index: indexPath.row, receiver: propertyIndex!)
        preselect = indexPath
        
        self.removeFromSuperview()
      //  settingDelegate?.settingSelector(sender: self, indexpath: path, setting: indexPath.row)
      
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SettingsTableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
//        if indexPath.row == 0{
//            cell.setSelected(true, animated: false)
//        }else{
//            cell.setSelected(false, animated: false)
//        }
        cell.settingName.text = data[indexPath.row]
        
        
        return cell
    }

    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.removeFromSuperview()
        //print("touched")
    }


}

