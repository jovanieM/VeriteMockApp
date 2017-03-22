//
//  PopUpPaperTypeVC.swift
//  KodakVer3
//
//  Created by anarte on 06/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol PaperTypeProtocol{
    func setTableRow(dataRow: String)
}

class PopUpPaperTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var paperTypeTable: UITableView!
    
    var data:String?
    var delegate: PaperTypeProtocol? = nil
    let textCellIdentifier = "cell"
    let defaultPaperType = UserDefaults.standard
    private let selectedKey = "choice"
    
    let paperTypeList = ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        paperTypeTable.delegate = self
        paperTypeTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paperTypeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = paperTypeTable.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
//        cell.textLabel?.text = paperTypeList[indexPath.row]
        let cell = SettingsTableViewCell(style: .default, reuseIdentifier: textCellIdentifier)
        cell.textLabel?.text = paperTypeList[indexPath.row]
        if indexPath.row == getDefault(){
         cell.isSelected = true
        }
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil{
            data = currentCell.textLabel?.text
            delegate?.setTableRow(dataRow: data!)
        }
        
        setDefault(value: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDefault(value: Int){
        defaultPaperType.set(value, forKey: selectedKey)
    }
    
    func getDefault()->Int{
        return defaultPaperType.integer(forKey: selectedKey)
    }

}
