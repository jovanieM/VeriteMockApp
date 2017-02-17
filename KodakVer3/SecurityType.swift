//
//  SecurityType.swift
//  KodakVer3
//
//  Created by anarte on 16/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class SecurityType: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var securityType: UITableView!
    
    let defaultSelection = UserDefaults.standard
    
    private let selectedCellKey = "choice"
    
    var cell: SettingsTableViewCell!
    
    private let kSeparatorID = 123
    private let kSeparatorHeight: CGFloat = 1.5
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    var security = ["Open", "WEP", "WPA/WPA2-PSK MIX", "WPA@-PSK AES"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table
        securityType.dataSource = self
        securityType.delegate = self
        securityType.backgroundColor = UIColor.gray
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return security.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = SettingsTableViewCell(style: .default, reuseIdentifier: "cellId2")
        cell.backgroundColor = UIColor.gray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = security[indexPath.row]
        
        return cell
    }
    
   
}
