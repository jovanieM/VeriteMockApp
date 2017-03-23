//
//  QuickViewController.swift
//  KodakVer3
//
//  Created by jmolas on 12/8/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit

protocol QuickViewControllerDelegate: class {
    func quickToDetail()
}

class QuickViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var quickSettings: UITableView!
    
    //private let selectedCellKey = "choice"
    //let defaultSelection = UserDefaults.standard
    weak var quickDelegate : QuickViewControllerDelegate?
    
    var sizes = ["Photo 4x6 in. borderless", "Photo Letter borderless", "Document Letter"]
    
    var cell: SettingsTableViewCell!
    
    var onSelect: (() -> Void)? = nil
    
    private let kSeparatorID = 123
    private let kSeparatorHeight: CGFloat = 1.5
    let button : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "checkmark_list"), for: .selected)
        return button
    }()
    
//    func setDefault(value : Int){
//        defaultSelection.set(value, forKey: selectedCellKey)
//    
//    }
//    func getDefault()->Int{
//        return defaultSelection.integer(forKey: selectedCellKey)
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickSettings.dataSource = self
        quickSettings.delegate = self
        quickSettings.backgroundColor = .black
        quickSettings.tableFooterView = UIView(frame: .zero)
        quickSettings.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: quickSettings.frame.width, height: kSeparatorHeight))
        quickSettings.tableHeaderView?.backgroundColor = .lightGray
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = SettingsTableViewCell(style: .default, reuseIdentifier: "cellId2")
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .lightGray
        cell.textLabel?.text = sizes[indexPath.row]
//        if indexPath.row == getDefault(){
//            cell.isSelected = true
//        }
      
        //cell.isSelected = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.viewWithTag(kSeparatorID) == nil
        {
            let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.height - kSeparatorHeight , width: cell.frame.width, height: kSeparatorHeight))
            separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            separatorView.backgroundColor = .lightGray
            cell.addSubview(separatorView)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
       // setDefault(value: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
        self.quickDelegate?.quickToDetail()
        self.onSelect!()
 
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        for index in 0..<sizes.count{
            cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as! SettingsTableViewCell!
            cell.accessoryView = .none
            
        }
        
       
        return indexPath
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
