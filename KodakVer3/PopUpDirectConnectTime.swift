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
    
    var userDefaults = UserDefaults.standard
    
    var data:String?
    var delegate:DirectConnectTimeProtocol? = nil
    
    let directTimeList: [String] = ["5 min", "10 min", "60min", "Unlimited"]
    let textCellIdIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        directConnectTable.delegate = self
        directConnectTable.dataSource = self
    }
    
    func setDefault(value: Int){
        //userDefaults.set(value, forKey: )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directTimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = directConnectTable.dequeueReusableCell(withIdentifier: textCellIdIdentifier, for: indexPath)
        cell.textLabel?.text = directTimeList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil {
            data = currentCell.textLabel?.text
            delegate?.setTableRowData(dataRow: data!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func popUpDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
