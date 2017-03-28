//
//  ScandocSettingViewController.swift
//  KodakVer3
//
//  Created by SQA on 08/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ScandocSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ScandocTableView: UITableView!

    var expandedSections : NSMutableSet = []
    
    var sectionData : [String] = ["Quality", "Color", "Document", "Save as type"]
    var row1 = ["Normal", "Low(Fast)", "High"]
    var row2 = ["Color", "Gray Scale", "Black and White"]
    var row3 = ["Text/Graphics", "Text"]
    var row4 = ["JPEG", "PDF"]
    
    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 3
    
    var expandedItemList = [Int]()
    var selectedIndexPathSection:Int = -1
    
    private let qualityKey: String = "Quality"
    private let colorKey: String = "Color"
    private let documentKey: String = "Document"
    private let saveasKey: String = "Save as type"
    
    let defaultQuality = UserDefaults.standard
    let defaultColor = UserDefaults.standard
    let defaultDocument = UserDefaults.standard
    let defaultSaveas = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    func setData (valueRow : Int, valueSection : Int) {
        switch valueSection {
        case 0:
            defaultQuality.set(valueRow, forKey: qualityKey)
        case 1:
            defaultColor.set(valueRow, forKey: colorKey)
        case 2:
            defaultDocument.set(valueRow, forKey: documentKey)
        case 3:
            defaultSaveas.set(valueRow, forKey: saveasKey)
        default:
            break
        }
    }
    
    func getSavedData (valueRow: Int) -> Int {
        switch valueRow {
        case 0:
            return defaultQuality.integer(forKey: qualityKey)
        case 1:
            return defaultColor.integer(forKey: colorKey)
        case 2:
            return defaultDocument.integer(forKey: documentKey)
        case 3:
            return defaultSaveas.integer(forKey: saveasKey)
        default:
            return 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScandocTableView.delegate = self
        ScandocTableView.dataSource = self
        
        ScandocTableView.backgroundColor = .black
        ScandocTableView.tableFooterView = UIView(frame: .zero)
        ScandocTableView.tableFooterView?.backgroundColor = .black
        
        
        
    }
    

    //button tapped on header cell
    func sectionTapped(sender:UIButton){
        
        let section = sender.tag
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.removeAllObjects()
            expandedSections.add(section)
        } else {
            expandedSections.removeAllObjects()
        }
        ScandocTableView.reloadData()
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
        let headerCell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        
        headerCell.mainLabel.text = sectionData[section]
        headerCell.headerCellButton.addTarget(self, action: #selector(sectionTapped), for: .touchUpInside)
        headerCell.headerCellButton.tag = section
        
            switch section {
            case 0:
                headerCell.selectedLabel.text = row1[(getSavedData(valueRow: 0))]
            case 1:
                headerCell.selectedLabel.text = row2[(getSavedData(valueRow: 1))]
            case 2:
                headerCell.selectedLabel.text = row3[(getSavedData(valueRow: 2))]
            case 3:
                headerCell.selectedLabel.text = row4[(getSavedData(valueRow: 3))]
            default:
                break
            }
        
        return headerCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(expandedSections.contains(section)){
            switch section {
            case 0:
                return row1.count
            case 1:
                return row2.count
            case 2:
                return row3.count
            case 3:
                return row4.count
            
            default:
                return 0
            }}
    return 0
    }
    
    //Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ItemsTableViewCell", owner: self, options: nil)?.first as! ItemsTableViewCell
        
        cell.checkmark.isHidden = true
        
        switch indexPath.section {
        case 0:
            cell.itemCell?.text = row1[indexPath.row]
            if(indexPath.row == getSavedData(valueRow: 0) ){
                cell.checkmark.isHidden = false
            } else {
                cell.checkmark.isHidden = true
            }


        case 1:
            cell.itemCell?.text = row2[indexPath.row]
            
            if(indexPath.row == getSavedData(valueRow: 1) ){
                cell.checkmark.isHidden = false
            } else {
                cell.checkmark.isHidden = true
            }
            
        case 2:
            cell.itemCell?.text = row3[indexPath.row]
            
            if(indexPath.row == getSavedData(valueRow: 2) ){
                cell.checkmark.isHidden = false
            } else {
                cell.checkmark.isHidden = true
            }
            
        case 3:
            cell.itemCell?.text = row4[indexPath.row]
            
            if(indexPath.row == getSavedData(valueRow: 3) ){
                cell.checkmark.isHidden = false
            } else {
                cell.checkmark.isHidden = true
            }
        default:
            return cell
        }

       return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ItemsTableViewCell
        
        cell.checkmark.isHidden = false
        
        NSLog("You selected cell #\(indexPath.section)!")
        NSLog("You selected cell #\(indexPath.row)!")
        
        setData(valueRow: indexPath.row, valueSection: indexPath.section)
        
        
        
        expandedSections.removeAllObjects()
        
        ScandocTableView.reloadData()
        
    }
        

}
