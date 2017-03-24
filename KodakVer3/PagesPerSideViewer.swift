//
//  PagesPerSideViewer.swift
//  KodakVer3
//
//  Created by SQA on 03/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol PagesPerSideDelegate {
    func sendData(index: Int, receiver: IndexPath)
}

class PagesPerSideViewer: UIView, UITableViewDelegate, UITableViewDataSource {

    
    var sendDataDelegate: PagesPerSideDelegate?
    var width: CGFloat!
    var preselect:IndexPath?
    
    var data: [(String, String)] = []{
        didSet{
            let tableView:UITableView = UITableView()
            tableView.frame = CGRect(x: 0, y: 0, width: width, height: CGFloat(computeHeight(numberOfItems: data.count)) * 85.0)
            
            
            let detail: CustomCopyViewController = CustomCopyViewController()
            
            let index: Int = detail.getSavedData(receiver: propertyIndex!.row)
            
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
        
    }
    
    func computeHeight(numberOfItems: Int) ->Int{
        if numberOfItems > 5 {
            let height = UIScreen.main.bounds.height * 0.8
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
                
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("PagesPerSideTableViewCell", owner: self, options: nil)?.first as! PagesPerSideTableViewCell
   
        cell.persideLabels.text = data[indexPath.row].0
        cell.persideImages.image = UIImage(named: data[indexPath.row].1)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.removeFromSuperview()
        //print("touched")
    }
        
}
