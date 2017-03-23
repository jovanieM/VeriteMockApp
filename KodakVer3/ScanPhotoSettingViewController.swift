//
//  ScanPhotoSettingViewController.swift
//  KodakVer3
//
//  Created by SQA on 08/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class ScanPhotoSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    @IBOutlet weak var ScandocTableView: UITableView!

    @IBOutlet weak var ScanPhotoTableView: UITableView!
    var expandedSections : NSMutableSet = []
    
    var sectionData : [String] = ["Quality", "Color", "Document"]
    var rowQuality = ["Normal", "Low(Fast)", "High"]
    var rowColor = ["Color", "Gray Scale", "Black & White"]
    var row3 = ["Photo"]
    
    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 8
    
    var expandedItemList = [Int]()
    var selectedIndexPathSection:Int = -1
    
    private let qualityKeyPhoto: String = "QualityPhoto"
    private let colorKeyPhoto: String = "ColorPhoto"
    private let documentKey: String = "Document"
    
    
    let defaultQualityPhoto = UserDefaults.standard
    let defaultColorPhoto = UserDefaults.standard
    let defaultDocument = UserDefaults.standard
    
    func setDataPhoto (valueRowPhoto : Int, valueSectionPhoto : Int) {
        switch valueSectionPhoto {
        case 0:
            defaultQualityPhoto.set(valueRowPhoto, forKey: qualityKeyPhoto)
        case 1:
            defaultColorPhoto.set(valueRowPhoto, forKey: colorKeyPhoto)
        case 2:
            defaultDocument.set(valueRowPhoto, forKey: documentKey)
        default:
            break
        }
    }
    
    func getSavedDataPhoto (valueRowPhoto: Int) -> Int {
        switch valueRowPhoto {
        case 0:
            return defaultQualityPhoto.integer(forKey: qualityKeyPhoto)
        case 1:
            return defaultColorPhoto.integer(forKey: colorKeyPhoto)
        case 2:
            return defaultDocument.integer(forKey: documentKey)
        default:
            return 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScanPhotoTableView.delegate = self
        ScanPhotoTableView.dataSource = self
        
        ScanPhotoTableView.backgroundColor = .black
        ScanPhotoTableView.tableFooterView = UIView(frame: .zero)
        ScanPhotoTableView.tableFooterView?.backgroundColor = .black
        
        
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
        ScanPhotoTableView.reloadData()
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
        let headerCellPhoto = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        
        headerCellPhoto.mainLabel.text = sectionData[section]
        headerCellPhoto.headerCellButton.addTarget(self, action: #selector(sectionTapped), for: .touchUpInside)
        headerCellPhoto.headerCellButton.tag = section
        
            switch section {
            case 0:
                headerCellPhoto.selectedLabel.text = rowQuality[(getSavedDataPhoto(valueRowPhoto: 0))]
            case 1:
                headerCellPhoto.selectedLabel.text = rowColor[(getSavedDataPhoto(valueRowPhoto: 1))]
            case 2:
            //    headerCell.selectedLabel.text = row3[(getSavedDataPhoto(valueRowPhoto: 2))]
                
                headerCellPhoto.selectedLabel.text = "Photo"
            default:
                break
            }
        
        return headerCellPhoto
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(expandedSections.contains(section)){
            switch section {
            case 0:
                return rowQuality.count
            case 1:
                return rowColor.count
            case 2:
                return row3.count
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
            cell.itemCell?.text = rowQuality[indexPath.row]
            
            if(indexPath.row == getSavedDataPhoto(valueRowPhoto: 0)){
                cell.checkmark.isHidden = false
            } else {
                cell.checkmark.isHidden = true
            }
            
        case 1:
            cell.itemCell?.text = rowColor[indexPath.row]
            
            if(indexPath.row == getSavedDataPhoto(valueRowPhoto: 1)){
                cell.checkmark.isHidden = false
            } else {
                cell.checkmark.isHidden = true
            }

        case 2:
            cell.itemCell?.text = row3[indexPath.row]
            
            if(indexPath.row == getSavedDataPhoto(valueRowPhoto: 2)){
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
        
        setDataPhoto(valueRowPhoto: indexPath.row, valueSectionPhoto: indexPath.section)
        
        
        
        expandedSections.removeAllObjects()
        
        ScanPhotoTableView.reloadData()

        
    }
        
}
