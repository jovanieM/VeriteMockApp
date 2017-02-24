//
//  SecurityType.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SecurityType: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableViewCell: UITableViewCell!
    
    @IBOutlet var tableView: UITableView!
    
    var securityType = ["Open", "WEP", "WPA/WPA2-PSK MIX", "WPA2-PSK AES"]
    
    var textCellIdentifier = "TextCell"
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(securityType[row])
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        let sb = UIStoryboard(name: "WiFiSetupStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "manual") as! NetworkAndPasswordManual
        vc.securityLabel?.text = currentCell.textLabel?.text
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
}
