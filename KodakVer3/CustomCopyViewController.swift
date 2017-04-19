//
//  CustomCopyViewController.swift
//  KodakVer3
//
//  Created by SQA on 23/02/2017.
//  Copyright © 2017 mmolo. All rights reserved.
//

import UIKit

// CopySettingsDelegate SettingViewDelegate

class CustomCopyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SettingViewDelegate, PagesPerSideDelegate {
  
  @IBOutlet weak var customcopybutton: UIButton!
  @IBOutlet weak var myScrollview: UIScrollView!
  
  var mainLabels: [String] = ["Color :", "Paper Size :", "Paper Type :", "Quality :", "Copy Resize :" ,"Pages per Side :", "Brightness :"]
  
  var subLabels: [[String]] = [["Color" ,"Black and White"], ["Letter", "Legal", "Executive", "Statement", "A4", "JIS B5", "A5", "A6", "4x6 in.", "3x5 in.", "5x7 in. (2L)", "3.5x5 in.(L)", "Hagaki", "10 Envelope", "DL Envelope", "C5 Envelope"], ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"], ["Text", "Text/Photo", "Photo", "Draft"], ["100% Default", "130% Letter->Legal", "104% Executive->Letter", "97% Letter->A4", "93% A4->Letter", "85% Letter->Executive", "Custom"] ,["One", "2 in 1 Portrait", "2 in 1 Landscape", "4 in 1 Portrait", "4 in 1 Landscape"], ["dummybrightness"]]
  
  var perSideArrays: [(String, String)] = [("One", "one.png"), ("2 in 1 Portrait", "two_portrait.png"), ("2 in 1 Landscape", "two_landscape.png"), ("4 in 1 Portrait", "four_portrait.png"), ("4 in 1 Landscape", "four_landscape.png")]
  
  @IBOutlet weak var customTable: UITableView!
  
  private let kSeparatorID = 123
  
  private let kSeparatorHeight: CGFloat = 1.0
  private let copyPaperSizeKey: String = "copyPaperSizeKey"
  private let copyColorKey: String = "copyColorKey"
  private let copyPaperTypeKey: String = "copyPaperTypeKey"
  private let copyQualityKey: String = "copyQualityKey"
  private let copyResizeKey: String = "copyResizeKey"
  private let pagespersideKey: String = "pagespersideKey"
  
  
  var table:SettingsViewer!
  //var table: CopySettingsViewer!
  var table2:PagesPerSideViewer!
  
  let defaultCopySize = UserDefaults.standard
  let defaultCopyColor = UserDefaults.standard
  let defaultCopyType = UserDefaults.standard
  let defaultCopyQuality = UserDefaults.standard
  let defaultCopyResize = UserDefaults.standard
  let defaultCopyPerSide = UserDefaults.standard
  
  
  var alert: UIAlertController!
  var cancel: UIAlertAction!
  var no: UIAlertAction!
  var include: UIAlertAction!
  var ok: UIAlertAction!
  var indicator: UIActivityIndicatorView!
  var time: DispatchTime!
  var doTask: DispatchWorkItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //button
    customcopybutton.layer.cornerRadius = 20
    customcopybutton.layer.borderWidth = 2
    customcopybutton.layer.borderColor = UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    customcopybutton.layer.masksToBounds = true;
    
    
    //table
    customTable.delegate = self
    customTable.dataSource = self
    customTable.backgroundColor = .black
    customTable.tableFooterView = UIView(frame: .zero)
    customTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: customTable.frame.width, height: kSeparatorHeight))
    customTable.tableHeaderView?.backgroundColor = .lightGray
    
  }
  
  @IBAction func customcopybuttonPressed(_ sender: Any) {
    
    let value: Int = selectedSettings[5]
    switch value{
    case 0:
      alertCopying()
      break
    case 1:
      alertTwoPageScanning()
      break
    case 2:
      alertTwoPageScanning()
      break
    case 3:
      alertFourPageScanning()
      break
    case 4:
      alertFourPageScanning()
      break
    default:
      break
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
    if cell.viewWithTag(kSeparatorID) == nil{
      let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.height - kSeparatorHeight , width: cell.frame.width, height: kSeparatorHeight))
      separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      separatorView.backgroundColor = .lightGray
      cell.addSubview(separatorView)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    return mainLabels.count
  }
  
  // display the corresponding custom copy settings table
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 6{
      let cell = Bundle.main.loadNibNamed("BrightnessTableViewCell", owner: self, options: nil)?.first as! BrightnessTableViewCell
      //cell.brightnessbar.isContinuous = true
      cell.brightnessbar.setThumbImage(UIImage(named: "seekbar_thumb"), for: .normal)
      cell.selectionStyle = .none
      return cell
      
    }else if indexPath.row == 4{
      let cell2 = Bundle.main.loadNibNamed("CustomCopyThirdCell", owner: self, options: nil)?.first as! CustomCopyThirdCell
      
      cell2.sizeToFit()
      cell2.textLabel?.numberOfLines = 2
      cell2.settingnameLabel.text = mainLabels[indexPath.row]
      cell2.selectedsettingLabel.text = "100%" //subLabels[indexPath.row][0]
      cell2.tfCustomResize.isHidden = true
      cell2.lblPercent.isHidden = true
      cell2.stpCustomResize.isHidden = true
      
      return cell2
    }else {
      
      let cell3 = Bundle.main.loadNibNamed("CustomCopySecondCell", owner: self, options: nil)?.first as! CustomCopySecondCell
      cell3.settingname.adjustsFontSizeToFitWidth = true
      cell3.settingname.text = mainLabels[indexPath.row]
      cell3.selectedsetting.text = subLabels[indexPath.row][0]
      //cell2.selectedsetting.text = subLabels[indexPath.row][getSavedData(receiver: indexPath.row) ?? 0]
      
      return cell3
      
    }
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 4{
      return 88
      
//      tableView.estimatedRowHeight = 44.0
//      tableView.rowHeight = UITableViewAutomaticDimension
//      
//      return UITableViewAutomaticDimension
    }else{
      return 44
    }
    
    
    
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  //display the corresponding tableview based on the selected custom copy settings
  
  var selectedSettings: [Int] = [0,0,0,0,0,0]
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath.row < 5{
      table  = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
      
      for i in 0..<5{
        if indexPath.row == i{
          table.preselect = selectedSettings[i]
        }
      }
      //table.preselect = getSavedData(receiver: indexPath.row)
      table.propertyIndex = indexPath
      table.data = subLabels[indexPath.row]
      
      table.sendDataDelegate = self
      tableView.deselectRow(at: indexPath, animated: false)
      self.view.window?.addSubview(table)
      
      
    }else if indexPath.row == 5{
      table2 = PagesPerSideViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
      table2.preselect = selectedSettings[indexPath.row]
      table2.propertyIndex = indexPath
      table2.data = perSideArrays
      
      
      table2.sendDataDelegate = self
      tableView.deselectRow(at: indexPath, animated: false)
      self.view.window?.addSubview(table2)
    }
  }
  
  
  func sendData(index: Int, receiver: IndexPath) {
    //setData(value: index, receiverIndex: receiver.row)
    selectedSettings[receiver.row] = index
    
    if receiver.row == 4 {
      print("index 4")
      let cell = self.customTable.cellForRow(at: receiver) as! CustomCopyThirdCell
      let str = subLabels[receiver.row][index]
      
      if str == "Custom" {
        cell.selectedsettingLabel.text = str
        cell.tfCustomResize.isHidden = false
        cell.lblPercent.isHidden = false
        cell.stpCustomResize.isHidden = false
        print("index 4: \(str)")
        
        let i = IndexPath(item: 5, section: 0)
        self.customTable.reloadRows(at: [i], with: .automatic)
        
        
        let alert = UIAlertController(title: "Pages per Side returned to One.", message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
          alert.dismiss(animated: true, completion: nil)
        })
      }else if str == "130% Letter->Legal" || str == "104% Executive->Letter" {
        let ind = str.index(str.startIndex, offsetBy: 5)
        cell.selectedsettingLabel.text = str.substring(to: ind)
        cell.tfCustomResize.isHidden = true
        cell.lblPercent.isHidden = true
        cell.stpCustomResize.isHidden = true
        print("index 4: \(str)")
        
        let indexPath = IndexPath(item: 5, section: 0)
        self.customTable.reloadRows(at: [indexPath], with: .automatic)
        
        let alert = UIAlertController(title: "Pages per Side returned to One.", message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
          alert.dismiss(animated: true, completion: nil)
        })

      }else if str == "97% Letter->A4" || str == "93% A4->Letter" || str == "85% Letter->Executive" {
        let ind = str.index(str.startIndex, offsetBy: 4)
        cell.selectedsettingLabel.text = str.substring(to: ind)
        cell.tfCustomResize.isHidden = true
        cell.lblPercent.isHidden = true
        cell.stpCustomResize.isHidden = true
        print("index 4: \(str)")
        
        let indexPath = IndexPath(item: 5, section: 0)
        self.customTable.reloadRows(at: [indexPath], with: .automatic)
        
        let alert = UIAlertController(title: "Pages per Side returned to One.", message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
          alert.dismiss(animated: true, completion: nil)
        })

      }else if str == "100% Default" {
        let ind = str.index(str.startIndex, offsetBy: 5)
        cell.selectedsettingLabel.text = str.substring(to: ind)
        cell.tfCustomResize.isHidden = true
        cell.lblPercent.isHidden = true
        cell.stpCustomResize.isHidden = true
        print("index 4: \(str)")
      }
      
    }else if receiver.row == 5{
      print("index 5")     
      let cell2 = self.customTable.cellForRow(at: receiver) as! CustomCopySecondCell
      let str1 = subLabels[receiver.row][index]
      
      if str1 == "One"{
        print("\(str1)")
        cell2.selectedsetting.text = str1
      }else{
        print("\(str1)")
        cell2.selectedsetting.text = str1
        
        let indexPath = IndexPath(item: 4, section: 0)
        self.customTable.reloadRows(at: [indexPath], with: .automatic)
        
        let alert = UIAlertController(title: "Resize returned to 100%.", message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
          alert.dismiss(animated: true, completion: nil)
        })
        
        
        
      }
      
    }else{
    
      let cell3 = self.customTable.cellForRow(at: receiver) as! CustomCopySecondCell
      cell3.selectedsetting.text = subLabels[receiver.row][index]
      
      print("\(cell3.selectedsetting.text)")
    }
  }
  
  
//--------------------------------------------------------------------------------------------------
  func alertCopying(){
    alert = UIAlertController(title: "Copying...\n\n", message: "", preferredStyle: .alert)
    cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
      self.alert.dismiss(animated: true, completion: nil)
      self.copyCancel()
    })
    alert.addAction(cancel)
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 40, height:40))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = .black
    alert.view.addSubview(indicator)
    indicator.startAnimating()
    present(alert, animated: true, completion: nil)
    
    let time = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: time){
      self.alert.dismiss(animated: true, completion: nil)
    }
  }
  
  var timer = Timer()
  
  func alertTwoPageScanning() {
    self.alert = UIAlertController(title: "Copy Pages per Side", message: "1st page Scanning...\n\n", preferredStyle: .alert)
    self.cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
      self.alert.dismiss(animated: true, completion: nil)
      self.timer.invalidate()
      self.copyCancel()
    })
    
    self.alert.addAction(self.cancel)
    self.indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 80, width: 40, height:40))
    self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.indicator.activityIndicatorViewStyle = .whiteLarge
    self.indicator.color = .black
    self.alert.view.addSubview(self.indicator)
    self.indicator.startAnimating()
    self.present(self.alert, animated: true, completion: nil)
    
    timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(alertFirstInclude), userInfo: nil, repeats: false)
  }
  
  func alertFirstInclude(){
    self.alert.dismiss(animated: true, completion: nil)
    
    self.alert = UIAlertController(title: "Copy Pages per Side", message: "Would you like to include another\n page?\n", preferredStyle: .alert)
    self.no = UIAlertAction(title: "NO", style: .default, handler: {(action: UIAlertAction) in
      self.alertCopying()
    })
    self.alert.addAction(self.no)
    
    let include = UIAlertAction(title: "Include", style: .default, handler: {(action: UIAlertAction) in
      self.alertSecondScanning()
    })
    self.alert.addAction(include)
    
    self.present(self.alert, animated: true, completion: nil)
  }
  
  func alertSecondScanning(){
    alert = UIAlertController(title: "Copy Pages per Side", message: "2nd page Scanning...\n\n", preferredStyle: .alert)
    cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
      self.alert.dismiss(animated: true, completion: nil)
      self.copyCancel()
    })
    alert.addAction(cancel)
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 80, width: 40, height:40))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = .black
    alert.view.addSubview(indicator)
    indicator.startAnimating()
    self.present(alert, animated: true, completion: nil)
    
    time = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: time){
      self.alert.dismiss(animated: true, completion: nil)
    }
  }
  
//--------------------------------------------------------------------------------------------------
  func alertFourPageScanning(){
    alert = UIAlertController(title: "Copy Pages per Side", message: "1st page Scanning...\n\n", preferredStyle: .alert)
    cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
      
      self.copyCancel()
    })
    alert.addAction(cancel)
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 80, width: 40, height:40))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = .black
    alert.view.addSubview(indicator)
    indicator.startAnimating()
    present(alert, animated: true, completion: nil)
    
    //time = DispatchTime.now() + 4.0
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
      self.alert.dismiss(animated: true, completion: nil)
      
      
        self.alert = UIAlertController(title: "Copy Pages per Side", message: "Would you like to include another\n page?\n", preferredStyle: .alert)
        self.no = UIAlertAction(title: "NO", style: .default, handler: {(action: UIAlertAction) in
          self.alertCopying()
        })
        self.alert.addAction(self.no)
        self.include = UIAlertAction(title: "Include", style: .default, handler: {(action: UIAlertAction) in
          self.alert = UIAlertController(title: "Copy Pages per Side", message: "2nd page Scanning...\n\n", preferredStyle: .alert)
          self.cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
            self.copyCancel()
          })
          self.alert.addAction(self.cancel)
          self.indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 80, width: 40, height:40))
          self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          self.indicator.activityIndicatorViewStyle = .whiteLarge
          self.indicator.color = .black
          self.alert.view.addSubview(self.indicator)
          self.indicator.startAnimating()
          self.present(self.alert, animated: true, completion: nil)
          
          self.time = DispatchTime.now() + 4.0
          DispatchQueue.main.asyncAfter(deadline: self.time){
            self.alert.dismiss(animated: true, completion: {
              self.alert = UIAlertController(title: "Copy Pages per Side", message: "Would you like to include another\n page?\n", preferredStyle: .alert)
              self.no = UIAlertAction(title: "NO", style: .default, handler: {(action: UIAlertAction) in
                self.alertCopying()
              })
              self.alert.addAction(self.no)
              self.include = UIAlertAction(title: "Include", style: .default, handler: {(action: UIAlertAction) in
                self.alert = UIAlertController(title: "Copy Pages per Side", message: "3rd page Scanning...\n\n", preferredStyle: .alert)
                self.cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
                  self.copyCancel()
                })
                self.alert.addAction(self.cancel)
                self.indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 80, width: 40, height:40))
                self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.indicator.activityIndicatorViewStyle = .whiteLarge
                self.indicator.color = .black
                self.alert.view.addSubview(self.indicator)
                self.indicator.startAnimating()
                self.present(self.alert, animated: true, completion: nil)
                
                self.time = DispatchTime.now() + 4.0
                DispatchQueue.main.asyncAfter(deadline: self.time){
                  self.alert.dismiss(animated: true, completion: {
                    self.alert = UIAlertController(title: "Copy Pages per Side", message: "Would you like to include another\n page?\n", preferredStyle: .alert)
                    self.no = UIAlertAction(title: "NO", style: .default, handler: {(action: UIAlertAction) in
                      self.alertCopying()
                    })
                    self.alert.addAction(self.no)
                    self.include = UIAlertAction(title: "Include", style: .default, handler: {(action: UIAlertAction) in
                      self.alert = UIAlertController(title: "Copy Pages per Side", message: "4th page Scanning...\n\n", preferredStyle: .alert)
                      self.cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) in
                        self.copyCancel()
                      })
                      self.alert.addAction(self.cancel)
                      self.indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 80, width: 40, height:40))
                      self.indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                      self.indicator.activityIndicatorViewStyle = .whiteLarge
                      self.indicator.color = .black
                      self.alert.view.addSubview(self.indicator)
                      self.indicator.startAnimating()
                      self.present(self.alert, animated: true, completion: nil)
                      
                      self.time = DispatchTime.now() + 4.0
                      DispatchQueue.main.asyncAfter(deadline: self.time){
                        self.alert.dismiss(animated: true, completion: nil)
                      }
                    })
                    self.alert.addAction(self.include)
                    self.present(self.alert, animated: true, completion: nil)
                    
                  })
                }
              })
              self.alert.addAction(self.include)
              self.present(self.alert, animated: true, completion: nil)
              
            })
          }
        })
        self.alert.addAction(self.include)
        self.present(self.alert, animated: true, completion: nil)
      
    }
    
    
  }
  
  func copyCancel(){
    alert = UIAlertController(title: "Canceling...\n\n", message: "", preferredStyle: .alert)
    indicator = UIActivityIndicatorView(frame: CGRect(x: 140,y: 70, width: 40, height:40))
    indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    indicator.activityIndicatorViewStyle = .whiteLarge
    indicator.color = .black
    alert.view.addSubview(indicator)
    indicator.startAnimating()
    present(alert, animated: true, completion: nil)
    
    let time = DispatchTime.now() + .seconds(4)
    DispatchQueue.main.asyncAfter(deadline: time){
      self.alert.dismiss(animated: true, completion: nil)
      self.copyCancelComplete()
    }
  }
  
  func copyCancelComplete(){
    alert = UIAlertController(title: "Copy Canceled.", message: "", preferredStyle: .alert)
    ok = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction) in
      self.alert.dismiss(animated: true, completion: nil)
    })
    alert.addAction(ok)
    present(alert, animated: true, completion: nil)
  }
}

extension String{
  func index(from: Int) -> Index{
    return self.index(startIndex, offsetBy: from)
  }
  
  func substring(to: Int) -> String{
    let toIndex = index(from: to)
    return substring(to: toIndex)
  }
  
  func substring(from: Int) -> String{
    guard from < self.characters.count else { return "" }
    let fromIndex = index(self.startIndex, offsetBy: from)
    return substring(from: fromIndex)
  }
}



//  func computeHeight(numberOfItems: Int) ->Int{
//    if numberOfItems > 5 {
//      let height = UIScreen.main.bounds.height * 0.8
//      return Int(height / 44.0)
//    }else{
//      return numberOfItems
//    }
//  }

//  func getSavedData(receiver: Int) -> Int?{
//
//    switch receiver {
//    case 1:
//      return defaultCopyColor.integer(forKey: copyColorKey)
//    case 2:
//      return defaultCopySize.integer(forKey: copyPaperSizeKey)
//    case 3:
//      return defaultCopyType.integer(forKey: copyPaperTypeKey)
//    case 4:
//      return defaultCopyQuality.integer(forKey: copyQualityKey)
//    case 5:
//      return defaultCopyResize.integer(forKey: copyResizeKey)
//    case 6:
//      return defaultCopyPerSide.integer(forKey: pagespersideKey)
//    default:
//      return 0
//    }
//
//  }

//  var copySize: SettingsObject?
//  var copyType: SettingsObject?
//  var copyQuality: SettingsObject?
//  var copyColor: SettingsObject?
//
//  func setData(value: Int, receiverIndex: Int){
//    switch receiverIndex {
//    case 1:
//      //copyColor?.color = [subLabels[1][value]]
//      defaultCopyColor.set(value, forKey: copyColorKey)
//    case 2:
//      //copySize?.paperSize = subLabels[2][value]
//      defaultCopySize.set(value, forKey: copyPaperSizeKey)
//    case 3:
//      defaultCopyType.set(value, forKey: copyPaperTypeKey)
//    case 4:
//      defaultCopyQuality.set(value, forKey: copyQualityKey)
//    case 5:
//      defaultCopyResize.set(value, forKey: copyResizeKey)
//    case 6:
//      defaultCopyPerSide.set(value, forKey: pagespersideKey)
//    default:
//      break
//    }
//  }

