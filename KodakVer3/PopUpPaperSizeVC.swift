//
//  PopUpPaperSizeVC.swift
//  KodakVer3
//
//  Created by anarte on 27/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol MyProtocol{
    func setTableRowData(dataRow: String)
}

class PopUpPaperSizeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablePaperSizes: UITableView!
    
    var data:String?
    
    var delegate: MyProtocol? = nil
    
    let paperSizeList = ["Letter", "Legal", "Executive", "Statement", "A4", "JIS B5", "A5", "A6", "4x6 in.", "3x5 in.", "5x7 in.(2L)", "3.5x5 in.(L)", "Hagaki", "10 Envelope", "DL Envelope", "C5 Envelope"]
    
    let textCellIdentifier  = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        tablePaperSizes.delegate = self
        tablePaperSizes.dataSource = self
    }
    
    //func numberOfSections(in tableView: UITableView) -> Int {
    //    return 1
    //}
    
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
        let cell = tablePaperSizes.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        //let row = indexPath.row
        cell.textLabel?.text = paperSizeList[indexPath.row]
        
        return cell
        
        /* let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = paperSizeList[indexPath.row]
        
        return(cell) */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //data = self.paperSizeList[indexPath.row]
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        if delegate != nil{
            data = currentCell.textLabel?.text
            delegate?.setTableRowData(dataRow: data!)
        }
        
        
        //let sb: UIStoryboard = UIStoryboard(name: "PrinterUtilityStoryboard", bundle: nil)
        //let sizeVC = sb.instantiateViewController(withIdentifier: "PaperSize") as! PaperSetup
        
        //sizeVC.paperSizeButton.titleLabel?.text = data
        print("\(data)")
        //self.navigationController?.popToViewController(sizeVC, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        //self.view.removeFromSuperview()
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
