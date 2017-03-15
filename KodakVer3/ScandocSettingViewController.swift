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
    var row2 = ["Color", "Gray Scale", "Black & White"]
    var row3 = ["Text/Graphics", "Text"]
    var row4 = ["JPEG", "PDF"]
    
    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 8
    
    var expandedItemList = [Int]()
    var selectedIndexPathSection:Int = -1
    
    private let qualityKey: String = "quality"
    private let colorKey: String = "color"
    private let documentKey: String = "document"
    private let saveasKey: String = "saveas"
    
    let defaultQuality = UserDefaults.standard
    let defaultColor = UserDefaults.standard
    let defaultDocument = UserDefaults.standard
    let defaultSaveas = UserDefaults.standard
    
    func setData (value : Int) {
        switch value {
        case 0:
            defaultQuality.set(value, forKey: qualityKey)
        case 1:
            defaultColor.set(value, forKey: colorKey)
        case 2:
            defaultDocument.set(value, forKey: documentKey)
        case 3:
            defaultSaveas.set(value, forKey: saveasKey)
        default:
            break
        }
    }
    
    func getSavedData (receiver: Int) -> Int {
        switch receiver {
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
    
    func sendData(index: Int) {
        setData(value: index)
        
        let cell = self.ScandocTableView.cellForRow(at: value) as! HeaderTableViewCell
        
        switch value {
        case 0:
            cell.selectedLabel.text = row1[index.row][getSavedData(receiver: index.row)]
        case 1:
            cell.selectedLabel.text = row2[index.row][getSavedData(receiver: index.row)]
        case 2:
            cell.selectedLabel.text = row3[index.row][getSavedData(receiver: index.row)]
        case 3:
            cell.selectedLabel.text = row4[index.row][getSavedData(receiver: index.row)]
        default:
            break
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScandocTableView.delegate = self
        ScandocTableView.dataSource = self
        
        ScandocTableView.backgroundColor = .black
        ScandocTableView.tableFooterView = UIView(frame: .zero)
  //      ScandocTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScandocTableView.frame.width, height: kSeparatorHeight))
        ScandocTableView.tableHeaderView?.backgroundColor = .lightGray
        //      detailSettings.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)

        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if view.viewWithTag(kSeparatorID) == nil
        {
            let separatorView = UIView(frame: CGRect(x: 0, y: view.frame.height - kSeparatorHeight , width: view.frame.width, height: kSeparatorHeight))
            separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            separatorView.backgroundColor = .black
            view.addSubview(separatorView)
            
        }

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
        
        switch indexPath.section {
        case 0:
            cell.itemCell?.text = row1[indexPath.row]
        case 1:
            cell.itemCell?.text = row2[indexPath.row]
        case 2:
            cell.itemCell?.text = row3[indexPath.row]
        case 3:
            cell.itemCell?.text = row4[indexPath.row]
        default:
            return cell
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setData(value: indexPath.row)
        
        expandedSections.removeAllObjects()
        
        ScandocTableView.reloadData()
        
    }
    
    
        
}
