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
  
  // navigation controller
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView(frame: .zero)
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
    print("\(String(describing: data))")
    
    _ = self.navigationController?.popViewController(animated: true)
  }
  
}
