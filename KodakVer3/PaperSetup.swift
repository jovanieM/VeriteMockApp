//
//  PaperSetup.swift
//  KodakVer3
//
//  Created by anarte on 23/02/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PaperSetup: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingViewDelegate {

  //PaperSizeProtocol, PaperTypeProtocol
  
  @IBOutlet weak var paperSizeButton: UIButton!
  @IBOutlet weak var paperTypeButton: UIButton!
  @IBOutlet weak var saveSettingButton: UIButton!
  @IBOutlet weak var descPaperSetup: UILabel!
  @IBOutlet weak var viewPaperSize: UIView!
  @IBOutlet weak var viewPaperType: UIView!
  @IBOutlet weak var tblPaperSetup: UITableView!
  
  var alert: UIAlertController!
  var alert2: UIAlertController!
  var alrController: UIAlertController!
  var indicator: UIActivityIndicatorView!
  var paperSizeData: String?
  var paperTypeData: String?
  var typeData: String?
  
  let defaults = UserDefaults.standard
  let sizeKey = "paperSize"
  let typeKey = "paperType"
  
  let listMainPaperSetup: [String] = ["Paper Size", "Paper Type"]
  
  let listPaperSettings: [[String]] = [["Letter", "Legal", "Executive", "Statement", "A4", "JIS B5", "A5", "A6", "4x6 in.", "3x5 in.", "5x7 in.(2L)", "3.5x5 in.(L)", "Hagaki", "10 Envelope", "DL Envelope", "C5 Envelope"], ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"]]
  
  // navigation bar
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadAlerts()
    
    // button
    saveSettingButton.layer.cornerRadius = 25
    saveSettingButton.layer.borderWidth = 2
    saveSettingButton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor

    tblPaperSetup.delegate = self
    tblPaperSetup.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listMainPaperSetup.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = Bundle.main.loadNibNamed("CustomCopySecondCell", owner: self, options: nil)?.first as! CustomCopySecondCell
   
    cell.settingname.text = listMainPaperSetup[indexPath.row]
    cell.settingname.textColor = .white
    cell.selectedsetting.text = listPaperSettings[indexPath.row][0]
    //[getSavedData(receiver: indexPath.row) ?? 0]
    
    
    let roundView: UIView = UIView(frame: CGRect(x: 0, y: 5, width: self.view.frame.size.width, height: (cell.contentView.frame.size.height)))
    roundView.layer.masksToBounds = true
    roundView.backgroundColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
    roundView.layer.cornerRadius = 2.0
    
    cell.contentView.addSubview(roundView)
    cell.contentView.sendSubview(toBack: roundView)
    return cell
  }
  
  var selected: [Int] = [0,0]
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let table: SettingsViewer = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    for i in 0..<2{
      if indexPath.row == i{
        table.preselect = selected[i]
      }
    }
    
    table.propertyIndex = indexPath
    table.data = listPaperSettings[indexPath.row]
    table.sendDataDelegate = self
    tableView.deselectRow(at: indexPath, animated: false)
    self.view.window?.addSubview(table)
  }
  
  var index1: Int!
  var recieve1: Int!
  var result: String!
  
  func sendData(index: Int, receiver: IndexPath){
    
    switch index {
    case 1:
      defaults.integer(forKey: sizeKey)
    case 2:
      defaults.integer(forKey: typeKey)
    default:
      break
    }
    
    selected[receiver.row] = index
    index1 = index
    recieve1 = receiver.row
    
    let cell = self.tblPaperSetup.cellForRow(at: receiver) as! CustomCopySecondCell
    cell.selectedsetting.text = result
    result = listPaperSettings[receiver.row][index]
  }
  
  @IBAction func saveSettingActionButton(_ sender: UIButton) {
    
    defaults.set(result, forKey: sizeKey)
    
    
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
  
  func loadAlerts(){
    
    descPaperSetup.isHidden = true
    viewPaperSize.isHidden = true
    viewPaperType.isHidden = true
    saveSettingButton.isHidden = true
    tblPaperSetup.isHidden = true
    
    
    alert = UIAlertController(title: "Getting Printer setting...\n\n", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
      self.dismiss(animated: true, completion: nil)
      _ = self.navigationController?.popViewController(animated: true)
    }))
    
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 50, height:50))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = UIColor.black
    
    alert.view.addSubview(indicator)
    indicator.startAnimating()
    self.present(alert, animated: true, completion: nil)
    
    _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
  }
  
  func dismissAlert(){
    self.alert?.dismiss(animated: true, completion: nil)
    
    descPaperSetup.isHidden = false
    viewPaperSize.isHidden = false
    viewPaperType.isHidden = false
    saveSettingButton.isHidden = false
    tblPaperSetup.isHidden = false
  }
}



//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "popUpPaperSize"{
//      let vc: PopUpPaperSizeVC = segue.destination as! PopUpPaperSizeVC
//      vc.delegate = self
//    }
//    else if segue.identifier == "popUpPaperType"{
//      let vc: PopUpPaperTypeVC = segue.destination as! PopUpPaperTypeVC
//      vc.delegate = self
//    }
//  }

//  override func viewDidAppear(_ animated: Bool) {
//    let size: String? = defaults.object(forKey: sizeKey) as? String
//    let type: String? = defaults.object(forKey: typeKey) as? String
//
//    if let sizeToDisplay = size {
//      paperSizeButton.titleLabel?.text = sizeToDisplay
//    }
//
//    if let typeToDisplay = type {
//      paperTypeButton.titleLabel?.text = typeToDisplay
//    }
//  }

//  func setPaperTypeData(dataRow: String) {
//    paperTypeButton.titleLabel!.text = dataRow
//    //typeData = dataRow
//    //defaults.set(dataRow, forKey: typeKey)
//  }
//
//  func setPaperSizeData(dataRow: String) {
//    paperSizeButton.titleLabel?.text = dataRow
//    //defaults.set(dataRow, forKey: sizeKey)
//  }

//  func setDataFromDisplay(dataSent: String){
//    self.paperSizeData = dataSent
//    self.paperTypeData = dataSent
//  }

//    //paperSizeButton.contentHorizontalAlignment = .right
//    paperSizeButton.titleEdgeInsets.right = 10
//    paperTypeButton.titleEdgeInsets.right = 10

//    if let sizeValue = defaults.string(forKey: sizeKey){
//      paperSizeButton.titleLabel?.text = sizeValue
//    }
//
//    if let typeValue = defaults.string(forKey: typeKey){
//      paperTypeButton.titleLabel?.text = typeValue
//    }

//  func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//    return 20
//  }
//
//  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//    let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 20)) as UIView
//
//    return view
//  }

