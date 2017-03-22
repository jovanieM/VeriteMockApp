//
//  PopUpPaperSizeVC.swift
//  KodakVer3
//
//  Created by anarte on 27/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol PaperSizeProtocol{
    func setTableRowData(dataRow: String)
}

class PopUpPaperSizeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablePaperSizes: UITableView!
    
    var data:String?
    var delegate: PaperSizeProtocol? = nil
    let textCellIdentifier  = "cell"
    let defaultPaperSize = UserDefaults.standard
    private let selectedKey = "choice"
    
    let paperSizeList = ["Letter", "Legal", "Executive", "Statement", "A4", "JIS B5", "A5", "A6", "4x6 in.", "3x5 in.", "5x7 in.(2L)", "3.5x5 in.(L)", "Hagaki", "10 Envelope", "DL Envelope", "C5 Envelope"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        tablePaperSizes.delegate = self
        tablePaperSizes.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (paperSizeList.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell = tablePaperSizes.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
//        cell.textLabel?.text = paperSizeList[indexPath.row]
        
        let cell = SettingsTableViewCell(style: .default, reuseIdentifier: textCellIdentifier)
        cell.textLabel?.text = paperSizeList[indexPath.row]
        if indexPath.row == getDefault(){
            cell.isSelected = true
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //data = self.paperSizeList[indexPath.row]
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil{
            data = currentCell.textLabel?.text
            delegate?.setTableRowData(dataRow: data!)
        }
        
        print("\(data)")
        
        setDefault(value: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setDefault(value: Int){
        defaultPaperSize.set(value, forKey: selectedKey)
    }

    func getDefault()->Int{
        return defaultPaperSize.integer(forKey: selectedKey)
    }

}
