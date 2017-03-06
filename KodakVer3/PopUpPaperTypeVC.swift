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
    
    let paperTypeList = ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"]
    
    let textCellIdentifier = "cell"
    
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
        let cell = paperTypeTable.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        cell.textLabel?.text = paperTypeList[indexPath.row]
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil{
            data = currentCell.textLabel?.text
            delegate?.setTableRow(dataRow: data!)
        }
        
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
