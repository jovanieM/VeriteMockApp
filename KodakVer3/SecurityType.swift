//
//  SecurityType.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol SecurityTypeProtocol{
    func setSecurityRowData(dataRow: String)
}

class SecurityType: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableViewCell: UITableViewCell!
    @IBOutlet var tableView: UITableView!
    
    var securityType = ["Open", "WEP", "WPA/WPA2-PSK MIX", "WPA2-PSK AES"]
    var textCellIdentifier = "TextCell"
    var data:String?
    var delegate:SecurityTypeProtocol? = nil
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return securityType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = securityType[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil{
            data = currentCell.textLabel?.text
            delegate?.setSecurityRowData(dataRow: data!)
        }
        print("\(data)")
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
