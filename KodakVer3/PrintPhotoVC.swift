//
//  PrintPhotoVC.swift
//  KodakVer3
//
//  Created by jmolas on 12/7/16.
//  Copyright © 2016 jmolas. All rights reserved.
//

import UIKit



class PrintPhotoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingViewDelegate  {
    
//    var set: Settings = Settings(paperSizes: .A4, paperTypes: .Labels, colorOutput: .Color, printQuality: .Best)
    
    
    
//    func updateUI(){
//        set.paperSizes = Settings.PaperSizes(rawValue: 4)!
//        
//       
//    }
    
    var arrayofMainLbl = ["dummy", "Paper Size :", "Color Output :", "Paper Type :", "Print Quality :"]
    
    var collections: [[String]] = [["dummy"],["4x6 in.", "4x6 in. Borderless", "3x5 in", "5x7 in.(2L)", "5x7 in.(2L) Borderless", "3.5x5 in.(L)", "3.5x5 in.(L) Borderless", "Letter", "Letter Borderless", "Legal", "Executive", "Statement", "A4", "A4 Borderless", "JIS B5", "A5", "A5 Borderless", "A6", "A6 Borderless", "Hagaki", "Hagaki BorderLess", "10 Envelope", "DL Envelope", "C5 Envelope"],  ["Color"], ["Plain", "Labels", "Envelope", "Glossy Photo", "Matte Photo"], ["Automatic", "Normal", "Best", "Draft"]]
    
  
    
    private let kSeparatorID = 123
    
    private let kSeparatorHeight: CGFloat = 1.0
    
    private let paperSizeKey: String = "size"
    private let colorOutKey: String = "color"
    private let typeKey: String = "type"
    private let qualityKey: String = "quality"
    
    let defaultSize = UserDefaults.standard
    let defaultColor = UserDefaults.standard
    let defaultType = UserDefaults.standard
    let defaultQuality = UserDefaults.standard
    
    var table : SettingsViewer!
    
    private let selectedCellKey = "choice"
    let defaultSelection = UserDefaults.standard
    
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var cell: SettingsTableViewCell!

    //----------------------------------
    @IBOutlet weak var iv: UIImageView!
   
    @IBOutlet weak var quickTableView: UITableView!
   
    
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var quickBtn: UIButton!
    
    @IBOutlet weak var detailSettings: UIImageView!
    
    
    var navbarHeight:CGFloat = UIScreen.main.bounds.height
    

    
    var sizes = ["Photo 4x6 in. Borderless", "Photo A4 Borderless", "Document A4"]
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "mySegue"{
////            let detailVC: DetailViewController = segue.destination as! DetailViewController
////            detailVC.delegate = self
//            
//        }
//        
//        
//    }
    
    func setDefault(value : Int){
        
        defaultSelection.set(value, forKey: selectedCellKey)
        
    }
    func getDefault()->Int{
        
        return defaultSelection.integer(forKey: selectedCellKey)
    }

    
    
    @IBAction func switcher(_ sender: UIButton) {
        let title = sender.currentTitle!
      
        
        if title == "Quick"{
            iv.image = #imageLiteral(resourceName: "settingtab_left")
            quickBtn.setTitleColor(UIColor.gold, for: .normal)
            quickBtn.titleLabel?.font = UIFont(name: (detailBtn.titleLabel?.font.fontName)!, size: 16)
            detailBtn.setTitleColor(.lightGray, for: .normal)
            detailBtn.titleLabel?.font = UIFont(name: (detailBtn.titleLabel?.font.fontName)!, size: 14)
            detailTableView.alpha = 0.0
            quickTableView.alpha = 1.0
            
        }else{
            iv.image = #imageLiteral(resourceName: "settingtab_right")
            //detailSettings.alpha = 1.0
            quickBtn.setTitleColor(.lightGray, for: .normal)
            quickBtn.titleLabel?.font = UIFont(name: (detailBtn.titleLabel?.font.fontName)!, size: 14)
            detailBtn.setTitleColor(UIColor.gold, for: .normal)
            detailBtn.titleLabel?.font = UIFont(name: (detailBtn.titleLabel?.font.fontName)!, size: 16)
            detailTableView.alpha = 1.0
            quickTableView.alpha = 0.0
            detailSettings.alpha = 1.0
            setDefault(value: 4)
            
            for i in 0..<sizes.count{
                quickTableView.cellForRow(at: IndexPath.init(row: i, section: 0))?.accessoryView = .none
           
            }
            
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quickTableView.delegate = self
        self.quickTableView.dataSource = self
        
        
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        
        self.detailTableView.backgroundColor = .black
        self.detailTableView.tableFooterView = UIView(frame: .zero)
        self.detailTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: detailSettings.frame.width, height: kSeparatorHeight))
        self.detailTableView.tableHeaderView?.backgroundColor = .lightGray
        
        self.quickTableView.backgroundColor = .black
        self.quickTableView.tableFooterView = UIView(frame: .zero)
        self.quickTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.quickTableView.frame.width, height: kSeparatorHeight))
        self.quickTableView.tableHeaderView?.backgroundColor = .lightGray
        
        
        
        
        if getDefault() == 4 || getDefault() == 0 {
            
            detailBtn.setTitleColor(UIColor.gold, for: .normal)
            detailBtn.titleLabel?.font = UIFont(name: (detailBtn.titleLabel?.font.fontName)!, size: 16)
            iv.image = #imageLiteral(resourceName: "settingtab_right")
            detailTableView.alpha = 1.0
            quickTableView.alpha = 0.0
            
            
            
        }else{
            quickBtn.setTitleColor(UIColor.gold, for: .normal)
            quickBtn.titleLabel?.font = UIFont(name: (detailBtn.titleLabel?.font.fontName)!, size: 16)
            iv.image = #imageLiteral(resourceName: "settingtab_left")
            detailTableView.alpha = 0.0
            quickTableView.alpha = 1.0
            detailSettings.alpha = 0.0
        }
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       self.navigationController?.navigationBar.layer.add(CATransition.popAnimationDisabler(), forKey: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.quickTableView{
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "any")
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .lightGray
            cell.textLabel?.text = sizes[indexPath.row]
            
            
            if indexPath.row == getDefault() - 1 {
                
                let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 44.0 * 0.467 , height: 44.0))
                iv.contentMode = .scaleAspectFill
                iv.image = #imageLiteral(resourceName: "checkmark_list")
                cell.accessoryView = iv

            }else{
                cell.accessoryView = .none
            }
            
            
//            cell = SettingsTableViewCell(style: .default, reuseIdentifier: "cellId2")
//            cell.backgroundColor = .black
//            cell.textLabel?.textColor = .lightGray
//            cell.textLabel?.text = sizes[indexPath.row]
            return cell
        
        }
        
        if tableView == self.detailTableView{
            
            if indexPath.row == 0 {
                
                let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
                
                
                cell.numberOfCopies.text = Int(cell.copiesStepper.value).description
                cell.selectionStyle = .none
                
                return cell
                
                
            }else{
                
                let cell2 = Bundle.main.loadNibNamed("TableViewCell2", owner: self, options: nil)?.first as! TableViewCell2
                cell2.mainLabel.adjustsFontSizeToFitWidth = true
                cell2.mainLabel.text = arrayofMainLbl[indexPath.row]
                //cell2.selectionLabel.text =
                cell2.selectionLabel.text = collections[indexPath.row][getSavedData(receiver: indexPath.row) ?? 0]
                
  
                return cell2
            }
        
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        
        if tableView == self.detailTableView{
            if indexPath.row == 0{
                return UIScreen.main.bounds.height * 0.11111
            }else{
                return UIScreen.main.bounds.height * 0.0778
            }
        }
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.quickTableView{
            return sizes.count
        }
        if tableView == self.detailTableView{
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.viewWithTag(kSeparatorID) == nil
        {
            let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.height - kSeparatorHeight , width: cell.frame.width, height: kSeparatorHeight))
            separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            separatorView.backgroundColor = .lightGray
            cell.tag = kSeparatorID
            cell.addSubview(separatorView)
            
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.detailTableView{
            if indexPath.row != 0{
                
                table  = SettingsViewer(frame: CGRect(x: UIScreen.main.bounds.minX, y:  UIScreen.main.bounds.minY, width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
                
                table.preselect = getSavedData(receiver: indexPath.row)
                
                table.propertyIndex = indexPath
                table.data = collections[indexPath.row]
                
                table.sendDataDelegate = self
                //setData(value: 0, receiverIndex: indexPath.row - 1)
                
                tableView.deselectRow(at: indexPath, animated: false)
                self.view.window?.addSubview(table)
                
                
            }
        }
        if tableView == self.quickTableView{
            
            self.detailSettings.alpha = 0.0
            
            for i in 0..<sizes.count{
                tableView.cellForRow(at: IndexPath.init(row: i, section: 0))?.accessoryView = .none
               
            }
            setDefault(value: indexPath.row + 1)
            let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 44.0 * 0.5 , height: 44.0))
            iv.contentMode = .scaleAspectFill
            iv.image = #imageLiteral(resourceName: "checkmark_list")
            tableView.cellForRow(at: indexPath)?.accessoryView = iv
            tableView.deselectRow(at: indexPath, animated: false)
            
            switch indexPath.row {
            case 0:
                sendData(index: 1, receiver: IndexPath.init(row: 1, section: 0))
                sendData(index: 3, receiver: IndexPath.init(row: 3, section: 0))
                sendData(index: 2, receiver: IndexPath.init(row: 4, section: 0))
                
            case 1:
                sendData(index: 13, receiver: IndexPath.init(row: 1, section: 0))
                sendData(index: 3, receiver: IndexPath.init(row: 3, section: 0))
                sendData(index: 2, receiver: IndexPath.init(row: 4, section: 0))
            case 2:
                
                sendData(index: 12, receiver: IndexPath.init(row: 1, section: 0))
                sendData(index: 0, receiver: IndexPath.init(row: 3, section: 0))
                sendData(index: 1, receiver: IndexPath.init(row: 4, section: 0))
                
            default:
                break
            }
            
           
            }
     
    }
    
    //----------------------------------------------------------
    
    func getSavedData(receiver: Int) -> Int?{
        
        switch receiver {
        case 1:
            return defaultSize.integer(forKey: paperSizeKey)
        case 2:
            return defaultColor.integer(forKey: colorOutKey)
        case 3:
            return defaultType.integer(forKey: typeKey)
        case 4:
            return defaultQuality.integer(forKey: qualityKey)
        default:
            return 0
        }
        
    }
    
    var settings : SettingsObject?

    
    func setData(value: Int, receiverIndex: Int){
        
        switch receiverIndex {
        case 1:
            settings?.paperSize = collections[1][value]
            defaultSize.set(value, forKey: paperSizeKey)
        case 2:
            defaultColor.set(value, forKey: colorOutKey)
        case 3:
            settings?.paperType = collections[3][value]
            defaultType.set(value, forKey: typeKey)
        case 4:
            settings?.printQuality = collections[4][value]
            defaultQuality.set(value, forKey: qualityKey)
        default:
            break
        }
    }
    
    func sendData(index: Int, receiver: IndexPath) {
        
        setData(value: index, receiverIndex: receiver.row)
        
        
        let cell = self.detailTableView.cellForRow(at: receiver) as! TableViewCell2
        
        cell.selectionLabel.text = collections[receiver.row][getSavedData(receiver: receiver.row) ?? 0]
    }
    

}

extension UIColor{
    @IBInspectable var gold:UIColor {
        return UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
    }
    
    static var gold: UIColor {
        return UIColor(red: 255/255, green: 183/255, blue: 0/255, alpha: 1.0)
    }
    static var aqua: UIColor{
        return UIColor(red: 22/255, green: 106/255, blue: 214/255, alpha: 1.0)
    }
    
}
