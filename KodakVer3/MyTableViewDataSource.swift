//
//  MyTableView.swift
//  KodakVer3
//
//  Created by jmolas on 1/5/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class MyTableViewDataSource: NSObject, UITableViewDataSource {
    
    var rowData:[String]!
    
    init(rowData: [String]){
        self.rowData = rowData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        assert(indexPath.section == 0)
        let cell:UITableViewCell = UITableViewCell()
        cell.textLabel?.text = rowData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    

    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
