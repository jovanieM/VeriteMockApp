//
//  DirectConnectTime.swift
//  KodakVer3
//
//  Created by anarte on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class DirectConnectTime: UIViewController, DirectConnectTimeProtocol  {
  // UITableViewDelegate, UITableViewDataSource
  
  @IBOutlet weak var saveSettingButton: UIButton!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var viewDirectConnect: UIView!
  @IBOutlet weak var directTimeLabel: UIButton!
  @IBOutlet weak var directLabel: UILabel!
  
  var alert: UIAlertController!
  var alert2: UIAlertController!
  var indicator: UIActivityIndicatorView!
  var directConnectTimeData: String?
  var directValue: String?
  
  let directDefaults = UserDefaults.standard
  private let directKey: String = "directKey"
  @IBOutlet weak var tblDirectConnect: UITableView!
  
  var directTimeItems: [String] = ["5 mins", "10 mins", "60 mins", "Unlimited"]
  var table: SettingsViewer!
  
  
  //navigation controller
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadAlerts()
    
    //button
    saveSettingButton.layer.cornerRadius = 25
    saveSettingButton.layer.borderWidth = 2
    saveSettingButton.layer.borderColor = UIColor(red: 254/255, green: 169/255, blue: 10/255, alpha: 1).cgColor
    
    let name: String? = directDefaults.object(forKey: "directLabel") as? String
    if let toDisplay = name{
      directLabel.text = toDisplay
    }


//    tblDirectConnect.delegate = self
//    tblDirectConnect.dataSource = self
//    tblDirectConnect.backgroundColor = .black
//    tblDirectConnect.tableFooterView = UIView(frame: .zero)
//    tblDirectConnect.tableHeaderView = UIView(frame: .zero)
  }
  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return directTimeItems.count
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = Bundle.main.loadNibNamed("TableViewCell2", owner: self, options: nil)?.first as! TableViewCell2
//    cell.mainLabel.text = "Direct Connect Time"
//    cell.selectionLabel.text = directTimeItems[indexPath.row]
//    
//    return cell
//  }
//  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    table = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//    table.propertyIndex = indexPath
//    table.data = directTimeItems[indexPath.row]
//    
//    tableView.deselectRow(at: indexPath, animated: false)
//    self.view.window?.addSubview(table)
//  }
  
  func loadAlerts(){
    desc.isHidden = true
    viewDirectConnect.isHidden = true
    saveSettingButton.isHidden = true
    
    alert = UIAlertController(title: "Getting Network \n information... \n", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
      self.dismiss(animated: true, completion: nil)
      _ = self.navigationController?.popViewController(animated: true)
    }))
    
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 90, width: 40, height:40))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = UIColor.black
    
    alert.view.addSubview(indicator)
    indicator.startAnimating()
    self.present(alert, animated: true, completion: nil)
    
    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
  }
  
  func dismissAlert(){
    alert.dismiss(animated: true, completion: nil)
    
    desc.isHidden = false
    viewDirectConnect.isHidden = false
    saveSettingButton.isHidden = false
  }
  
  @IBAction func saveSettingActionButton(_ sender: UIButton) {
    
//    directDefaults.set(directLabel.text, forKey: "directLabel")
    
    alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
    
    indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = UIColor.black
    
    alert.view.addSubview(indicator)
    indicator.isUserInteractionEnabled = false
    indicator.startAnimating()
    
    self.present(alert, animated: true, completion: nil)
    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
  }
  
  func dismissAlert_2(){
    self.alert?.dismiss(animated: true, completion: {
      self.alert2 = UIAlertController(title: "", message: "Setting is saved", preferredStyle: .alert)
      self.present(self.alert2, animated: true, completion: {
        //self.alert2?.dismiss(animated: true, completion: nil)
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissAlert_3), userInfo: nil, repeats: false)
      })
    })
  }
  
  func dismissAlert_3(){
    self.alert2?.dismiss(animated: true, completion: nil)
    _ = navigationController?.popViewController(animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "popUpDirectConnect"{
      let vc: PopUpDirectConnectTime = segue.destination as! PopUpDirectConnectTime
      vc.delegate = self
    }
  }
  
  func setDataFromDisplay(dataSent: String){
    self.directConnectTimeData = dataSent
  }
  
  func setTableRowData(dataRow: String) {
    directLabel.text = dataRow
    //directValue = dataRow
    //directDefaults.set(, forKey: "directLabel")
  }
  
  
  
}



