//
//  PopupViewController.swift
//  kodak
//
//  Created by Miravy Molo on 1/8/17.
//  Copyright © 2017 Miravy Molo. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet var popupView: UIView!
    
    let printerlist = ["KODAK VERITE 1", "KODAK VERITE 2", "KODAK VERITE 3", "KODAK VERITE 4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
                
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return printerlist.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
    //    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = printerlist[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "mysegue", sender: printerlist[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mysegue" {
            
            let guest = segue.destination as! FirstViewController
            
            guest.printer = sender as? String
            
        }
       
    }
    
    
    @IBAction func closePopup(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
