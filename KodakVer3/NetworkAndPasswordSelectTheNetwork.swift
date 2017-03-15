//
//  NetworkAndPasswordSelectTheNetwork.swift
//  KodakVer3
//
//  Created by anarte on 15/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//


import UIKit

protocol SelectNetworkProtocol{
   func setSelectNetworkData(dataRow: String)
}

class NetworkAndPasswordSelectTheNetwork: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableNetworkView: UITableView!
    @IBOutlet weak var btnManual: UIButton!
    @IBOutlet weak var tableViewCell: UITableViewCell!
    
    var cellIdentifier = "Cell"
    var networks = ["Router 1", "Router 2", "Router 3", "Printer 1", "Printer 2", "Printer 3"]
    var data: String?
    var delegate: SelectNetworkProtocol?
    
    //let defaultSelection = UserDefaults.standard
    
    // navigation bar
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table
        tableNetworkView.dataSource = self
        tableNetworkView.delegate = self
        //tableView.backgroundColor = .lightGray
        //tableView.tableFooterView = UIView(frame: .zero)
        //tableView.tableHeaderView = UIView(frame: .zero)
        //tableView.tableHeaderView?.backgroundColor = .lightGray
        
        //button
        btnManual.layer.cornerRadius = 25
        btnManual.layer.borderWidth = 2
        btnManual.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< back", style: .plain, target: self, action: #selector(backAction))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableNetworkView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = networks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        //if delegate != nil{
            data = currentCell.textLabel?.text
            delegate?.setSelectNetworkData(dataRow: data!)
        //}
        
        //let viewController: NetworkAndPasswordSelectedNetworkVC = storyboard?.instantiateViewController(withIdentifier: "SelectedNetwork") as! NetworkAndPasswordSelectedNetworkVC
        //viewController.ssidLabel.text = data
        
        //self.navigationController?.pushViewController(viewController, animated: true)
        
                
        //if delegate != nil{
        //}
        print("\(data)")
        //data = currentCell.textLabel?.text
        //performSegue(withIdentifier: "toSelectedNetwork", sender: self)
        
    }
    
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectedNetwork"{
            let vc = segue.destination as! NetworkAndPasswordSelectedNetworkVC
            //delegate?.setSelectNetworkData(dataRow: data!)
            vc.ssidLabel.text = data
        }
    }*/
    
    func backAction(){
        let vc: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in vc{
            if aViewController is WiFiSetupHome{
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
}

