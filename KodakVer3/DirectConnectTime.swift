//
//  DirectConnectTime.swift
//  KodakVer3
//
//  Created by anarte on 21/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class DirectConnectTime: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingViewDelegate {
  // UITableViewDelegate, UITableViewDataSource, DirectConnectTimeProtocol
  
  @IBOutlet weak var saveSettingButton: UIButton!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var viewDirectConnect: UIView!
  @IBOutlet weak var directTimeLabel: UIButton!
  @IBOutlet weak var directLabel: UILabel!
  @IBOutlet weak var tblDirect: UITableView!
  
  var alert: UIAlertController!
  var alert2: UIAlertController!
  var indicator: UIActivityIndicatorView!
  var directConnectTimeData: String?
  var directValue: String?
  
  let directDefaults = UserDefaults.standard
  private let directKey: String = "directKey"
  
  var table: SettingsViewer!
  var time: DispatchTime!
  
  var mainLabel: [String] = ["Direct Connect Time"]
  var directTimeList: [[String]] = [["5 min", "10 min", "60 min", "Unlimited"]]
  
  //navigation controller
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadAlerts()
    
    tblDirect.delegate = self
    tblDirect.dataSource = self
    
    //button
    saveSettingButton.layer.cornerRadius = 25
    saveSettingButton.layer.borderWidth = 2
    saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    
    //    let name: String? = directDefaults.object(forKey: directKey) as? String
    //    if let toDisplay = name{
    //      directLabel.text = toDisplay
    //    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mainLabel.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = Bundle.main.loadNibNamed("CustomCopySecondCell", owner: self, options: nil)?.first as! CustomCopySecondCell
    
    cell.settingname.textColor = .white
    cell.settingname.text = mainLabel[indexPath.row]
    cell.contentView.backgroundColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
    cell.selectedsetting.textColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    
    cell.selectedsetting.text = directTimeList[indexPath.row][getSavedData(receiver: indexPath.row) ?? 0]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    table = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height))
    
    table.preselect = getSavedData(receiver: indexPath.row)
    table.propertyIndex = indexPath
    table.data = directTimeList[indexPath.row]
    
    table.sendDataDelegate = self
    tableView.deselectRow(at: indexPath, animated: false)
    self.view.window?.addSubview(table)
  }
  
  func getSavedData(receiver: Int) -> Int?{
    return directDefaults.integer(forKey: directKey)
  }
  
  func setData(value: Int, receiverIndex: Int){
    directDefaults.set(value, forKey: directKey)
  }
  
  func sendData(index: Int, receiver: IndexPath) {
    setData(value: index, receiverIndex: receiver.row)
    
    let cell = self.tblDirect.cellForRow(at: receiver) as! CustomCopySecondCell
    cell.selectedsetting.text = directTimeList[receiver.row][getSavedData(receiver: receiver.row) ?? 0]
  }
  
  func loadAlerts(){
    desc.isHidden = true
    viewDirectConnect.isHidden = true
    saveSettingButton.isHidden = true
    tblDirect.isHidden = true
    
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
    
    //    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    
    time = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: time){
      self.alert.dismiss(animated: true, completion: nil)
      
      self.desc.isHidden = false
      self.viewDirectConnect.isHidden = false
      self.saveSettingButton.isHidden = false
      self.tblDirect.isHidden = false
    }
  }
  
  //  func dismissAlert(){
  //    alert.dismiss(animated: true, completion: nil)
  //
  //    desc.isHidden = false
  //    viewDirectConnect.isHidden = false;
  //    saveSettingButton.isHidden = false
  //  }
  
  @IBAction func saveSettingActionButton(_ sender: UIButton) {
    
    //setData(value: preSelect, receiverIndex: path.row)
    
    alert = UIAlertController(title: "Setting... \n\n", message: "", preferredStyle: .alert)
    
    indicator = UIActivityIndicatorView(frame: CGRect(x: 135, y: 70, width: 50, height:50))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = UIColor.black
    
    alert.view.addSubview(indicator)
    indicator.isUserInteractionEnabled = false
    indicator.startAnimating()
    
    self.present(alert, animated: true, completion: nil)
    //    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert_2), userInfo: nil, repeats: false)
    
    time = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: time){
      self.alert?.dismiss(animated: true, completion: {
        self.alert2 = UIAlertController(title: "", message: "Setting is saved", preferredStyle: .alert)
        self.present(self.alert2, animated: true, completion: {
          //self.alert2?.dismiss(animated: true, completion: nil)
          //          _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissAlert_3), userInfo: nil, repeats: false)
          self.time = DispatchTime.now() + 4.0
          DispatchQueue.main.asyncAfter(deadline: self.time){
            self.alert2?.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
          }
        })
      })
      
    }
  }
  //  func dismissAlert_2(){
  //    self.alert?.dismiss(animated: true, completion: {
  //      self.alert2 = UIAlertController(title: "", message: "Setting is saved", preferredStyle: .alert)
  //      self.present(self.alert2, animated: true, completion: {
  //        //self.alert2?.dismiss(animated: true, completion: nil)
  //        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissAlert_3), userInfo: nil, repeats: false)
  //      })
  //    })
  //  }
  
  //  func dismissAlert_3(){
  //    self.alert2?.dismiss(animated: true, completion: nil)
  //    _ = navigationController?.popViewController(animated: true)
  //  }
  
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //    if segue.identifier == "popUpDirectConnect"{
  //      let vc: PopUpDirectConnectTime = segue.destination as! PopUpDirectConnectTime
  //      vc.delegate = self
  //    }
  //  }
  
  //  func setDataFromDisplay(dataSent: String){
  //    self.directConnectTimeData = dataSent
  //  }
  
  
  //  func setTableRowData(dataRow: String) {
  //    directLabel.text = dataRow
  //  }
  
}
