//
//  CopySettingsViewer.swift
//  KodakVer3
//
//  Created by anarte on 31/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol CopySettingsDelegate: class{
    func sendData(index: Int, receiver: IndexPath)
}

class CopySettingsViewer: UIView, UITableViewDelegate, UITableViewDataSource {

    var sendCopyDelegate: CopySettingsDelegate? = nil
    var width: CGFloat!
    var preselect: Int?
    var select: IndexPath?
    var propertyIndex: IndexPath?
    var cell: SettingsTableViewCell!
    let textID = "cell"
    
    var data: [String] = []{
        didSet{
            let tableView: UITableView = UITableView()
            tableView.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat(computeHeight(numberOfItems: data.count))*44.0)
            
            let detail: CustomCopyViewController = CustomCopyViewController()
            let index: Int = detail.getSavedData(receiver: propertyIndex!.row)
            
            tableView.center = convert(center, from: self)
            tableView.delegate = self
            tableView.dataSource = self
//            tableView.selectRow(at: IndexPath.init(row: preselect ?? 0, section: 0), animated: false, scrollPosition: .middle)
            tableView.selectRow(at: IndexPath.init(row: index, section: 0), animated: false, scrollPosition: .middle)
            self.addSubview(tableView)
        }
    }
   
    func computeHeight(numberOfItems: Int) -> Int{
        if numberOfItems > 5 {
            let height = UIScreen.main.bounds.height * 0.7
            return Int(height/44.0)
        }else{
            return numberOfItems
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        width = frame.width
        self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = SettingsTableViewCell(style: .default, reuseIdentifier: textID)
//        cell.preservesSuperviewLayoutMargins = false
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
        cell.settingName.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if sendCopyDelegate != nil{
            sendCopyDelegate?.sendData(index: indexPath.row, receiver: propertyIndex!)
        }
            //select = indexPath
        self.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.removeFromSuperview()
    }
}
