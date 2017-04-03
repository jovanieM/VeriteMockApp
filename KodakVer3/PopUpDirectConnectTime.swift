//
//  popUpDirectConnectTime.swift
//  KodakVer3
//
//  Created by anarte on 06/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol DirectConnectTimeProtocol {
    func setTableRowData(dataRow: String)
}

class PopUpDirectConnectTime: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var directConnectTable: UITableView!
    
    let directTimeDefault = UserDefaults.standard
    private let selectedKey = "choice"
    
    var data:String?
    var delegate:DirectConnectTimeProtocol? = nil
    
    let directTimeList: [String] = ["5 min", "10 min", "60min", "Unlimited"]
    let textCellIdIdentifier = "cell"
    var cell: SettingsTableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        directConnectTable.delegate = self
        directConnectTable.dataSource = self       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directTimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = SettingsTableViewCell(style: .default, reuseIdentifier: textCellIdIdentifier)
        cell.textLabel?.text = directTimeList[indexPath.row]
        if indexPath.row == getDefault(){
            cell.isSelected = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil {
            data = currentCell.textLabel?.text
            delegate?.setTableRowData(dataRow: data!)
        }
        
        setDefault(value: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: true, completion: nil)
    }

    func setDefault(value: Int){
        directTimeDefault.set(value, forKey: selectedKey)
    }
    
    func getDefault()->Int{
        return directTimeDefault.integer(forKey: selectedKey)
    }
    
    @IBAction func popUpDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
