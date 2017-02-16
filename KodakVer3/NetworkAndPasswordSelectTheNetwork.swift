//
//  NetworkAndPasswordSelectTheNetwork.swift
//  KodakVer3
//
//  Created by anarte on 15/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//


import UIKit

class NetworkAndPasswordSelectTheNetwork: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var listOfNetworks: UITableView!
    
    @IBOutlet weak var btnManual: UIButton!
    
    var cell: SettingsTableViewCell!
    
    let defaultSelection = UserDefaults.standard
    
    private let selectedCellKey = "choice"
    
    private let kSeparatorID = 123
    private let kSeparatorHeight: CGFloat = 1.5
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    var networks = ["Router 1", "Router 2", "Router 3", "Printer 1", "Printer 2", "Printer 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table
        listOfNetworks.dataSource = self
        listOfNetworks.delegate = self
        listOfNetworks.backgroundColor = .lightGray
        listOfNetworks.tableFooterView = UIView(frame: .zero)
        listOfNetworks.tableHeaderView = UIView(frame: .zero)
        listOfNetworks.tableHeaderView?.backgroundColor = .lightGray
        
        //button
        btnManual.layer.cornerRadius = 25
        btnManual.layer.borderWidth = 2
        btnManual.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    }
    
    func setDefault(value: Int){
        defaultSelection.set(value, forKey: selectedCellKey)
    }
    
    func getDefault()->Int{
        return defaultSelection.integer(forKey: selectedCellKey)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = SettingsTableViewCell(style: .default, reuseIdentifier: "cellId2")
        cell.backgroundColor = UIColor.gray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = networks[indexPath.row]
        if indexPath.row == getDefault(){
            cell.isSelected = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.viewWithTag(kSeparatorID) == nil{
            let separatorView = UIView(frame: CGRect(x:0, y: cell.frame.height - kSeparatorHeight, width: cell.frame.width, height: kSeparatorHeight))
            separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            separatorView.backgroundColor = .lightGray
            cell.addSubview(separatorView)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setDefault(value: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        for index in 0..<networks.count{
            cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as! SettingsTableViewCell!
            cell.accessoryView = .none
        }
        
        return indexPath
    }
}

