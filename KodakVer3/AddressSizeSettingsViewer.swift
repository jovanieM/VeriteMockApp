//
//  PreviewViewController.swift
//  KodakVer3
//
//  Created by SQA on 31/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

//provides the newly selected index to the DetailviewController
protocol AddressSizeViewDelegate: class {
    func sendAddressPrintData(index: Int, receiver: Int)
}

class AddressSizeSettingsViewer: UIView, UITableViewDelegate, UITableViewDataSource{
    
    
    
    weak var sendAddressPrintDelegate: AddressSizeViewDelegate?
    
    var width: CGFloat!
    
    var preselect:Int?
    
    let fontStyles = NSMutableAttributedString()
    
    var klass : UIViewController?{
        didSet{
            print(klass?.description ?? "sany")
        }
    }
    
    
    
    //creates a tableView for list of settings once the data has been set
    var data: [String] = []{
        didSet{
            let tableView:UITableView = UITableView()
            tableView.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat(computeHeight(numberOfItems: data.count)) * 44.0)
            
            
            tableView.center = convert(center, from: self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.selectRow(at: IndexPath.init(row: preselect ?? 0, section: 0), animated: false, scrollPosition: .middle)
            self.addSubview(tableView)
            
            
        }
    }
    
    var dataNS: [NSMutableAttributedString] = []{
        didSet{
            let tableView:UITableView = UITableView()
            tableView.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat(computeHeight(numberOfItems: dataNS.count)) * 44.0)
            
            
            tableView.center = convert(center, from: self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.selectRow(at: IndexPath.init(row: preselect ?? 0, section: 0), animated: false, scrollPosition: .middle)
            self.addSubview(tableView)
            
            
        }
    }
    
    var propertyIndex: Int?
    var delegate: loadData?
    
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
        
        sendAddressPrintDelegate?.sendAddressPrintData(index: indexPath.row, receiver: propertyIndex!)
    
        preselect = indexPath.row
        
        print("test")
        self.removeFromSuperview()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = SettingsTableViewCell(style: .default, reuseIdentifier: "cellId")
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        if propertyIndex == 1{
            cell.settingName.text = data[indexPath.row]
            let fontsize = cell.settingName.font.pointSize
            
            switch indexPath.row {
            case 0:
                cell.settingName.font = UIFont(name: "Times New Roman", size: fontsize)
            case 1:
                cell.settingName.font = UIFont(name: "Arial", size: fontsize)
            case 2:
                cell.settingName.font = UIFont(name: "Marker Felt", size: fontsize)
            case 3:
                cell.settingName.font = UIFont(name: "Snell Roundhand", size: fontsize)
            default:
                break
            }
            
        } else {
        
        cell.settingName.text = data[indexPath.row]
        }
        return cell
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.removeFromSuperview()
        //print("touched")
    }
    
    
}

