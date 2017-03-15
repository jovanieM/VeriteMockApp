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

    
    var topItems = ["Quality", "Color", "Document"]
    var subItems: [[String]] = [["Normal", "Low(Fast)", "High"], ["Color", "Gray Scale", "Black & White"], ["Photo"] ]
    var expandedItemList = [Int]()
    var selectedIndexPathSection:Int = -1
    
    var sectionData: [Int: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScandocTableView.delegate = self
        ScandocTableView.dataSource = self
        
        sectionData = [0: subItems[0], 1:subItems[1], 2:subItems[2]]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
 
        let headerCell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        
        headerCell.mainLabel.text = topItems[section]
        
        headerCell.headerCellButton.tag = section+100
        headerCell.headerCellButton.addTarget(self, action: Selector("headerCellButtonTapped:"), for: UIControlEvents.touchUpInside)
    
//        if(expandedItemList.contains(section)){
//            UIView.animate(withDuration: 0.3, delay: 1.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {headerCell.expandCollapseImageView.image = UIImage(named: "maximize")}, completion: nil)
//        } else{
//            UIView.animate(withDuration: 0.3, delay: 1.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {headerCell.expandCollapseImageView.image = UIImage(named: "minimize")}, completion: nil)
//        }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        for i in expandedItemList.count {
//            if(expandedItemList[i] == section){
//                i == expandedItemList.count
//                return 0
//           }
//        }
            return subItems.count
    }
    
    //Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ItemsTableViewCell", owner: self, options: nil)?.first as! ItemsTableViewCell
        
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTableViewCell", for: indexPath) as! ItemsTableViewCell
        cell.itemCell?.text = sectionData[indexPath.section]![indexPath.row]
        
        return cell
    }
    
    
    //button tapped on header cell
    func headerCellButtonTapped(sender:UIButton){
        
        for i in expandedItemList {
            if(expandedItemList[i] == (sender.tag-100)){
                
                expandedItemList.remove(at: i)
                self.ScandocTableView.reloadData()
                
                return
            }
        
        }
        selectedIndexPathSection = sender.tag - 100
        expandedItemList.append(selectedIndexPathSection)
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.ScandocTableView.reloadData()}, completion: nil)
    }
    
}
