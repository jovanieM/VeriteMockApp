//
//  MyTableViewDelegate.swift
//  KodakVer3
//
//  Created by jmolas on 1/9/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol SelectSettings{
    func reloadView(indexPath: IndexPath, selectedCell: Int, choice: Int)
}

class MyTableViewDelegate: NSObject, UITableViewDelegate {
    
    
    var selectedRow: Int
    var indexPath: IndexPath
    
    init(indexPath: IndexPath, selectedRow: Int) {
        self.selectedRow = selectedRow
        self.indexPath = indexPath
    }
    
    var mySelector: SelectSettings?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mySelector?.reloadView(indexPath: self.indexPath, selectedCell: selectedRow, choice: indexPath.row)
//        let s = indexPath.row
//        print(s)
        tableView.removeFromSuperview()
    }
    
   
    
    
}
