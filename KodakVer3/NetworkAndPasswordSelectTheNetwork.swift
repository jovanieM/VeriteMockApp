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
   
    
    var cellIdentifier = "Cell"
    var networks = ["Router 1", "Router 2", "Router 3", "Printer 1", "Printer 2", "Printer 3"]
    var data: String?
    var delegate: SelectNetworkProtocol?
    var cell: UITableViewCell!
    
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
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.detailTextLabel?.text = "Connected"
//        cell.detailTextLabel?.isHidden = true
        cell.textLabel?.text = networks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as UITableViewCell
//        cell.detailTextLabel?.text = "Connected"
//        cell.detailTextLabel?.isHidden = false
        
        for cell in tableView.visibleCells{
            cell.detailTextLabel?.isHidden = true
        }
        let cell1 = tableView.cellForRow(at: indexPath)
        cell1?.detailTextLabel?.isHidden = false
        
        performSegue(withIdentifier: "toSelectedNetwork", sender: networks[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectedNetwork"{
            let vc = segue.destination as! NetworkAndPasswordSelectedNetworkVC
            vc.networkData = sender as? String
        }
    }
    
    @IBAction func manualButton(_ sender: UIButton) {
        
        let sb: UIStoryboard = UIStoryboard(name: "WiFiSetupStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "manual") as! NetworkAndPasswordManual
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func backAction(){
        let vc: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in vc{
            if aViewController is WiFiSetupHome{
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
}

