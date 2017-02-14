//
//  QuickViewController.swift
//  KodakVer3
//
//  Created by jmolas on 12/8/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit

class QuickViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var quickSettings: UITableView!
    
    var sizes = ["Photo 4x6 in. borderless", "Photo Letter borderless", "Document Letter"]
    
    private let kSeparatorID = 123
    private let kSeparatorHeight: CGFloat = 1.5
    
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
        let cell = UITableViewCell()
        cell.textLabel?.text = sizes[indexPath.row]
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.lightGray
        
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
        
        
        for index in 0..<sizes.count{
            if index == indexPath.row{
                if let cell = tableView.cellForRow(at: indexPath){
                    let image = UIImage(named: "checkmark_list")
                    let imageView = UIImageView (image: image)
                    
                    cell.accessoryView = imageView
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
                }

            }else{
            }
        }
        }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
//        if let cell = tableView.cellForRow(at: indexPath){
//            cell.accessoryView = .none
//        }
//    }
    
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
