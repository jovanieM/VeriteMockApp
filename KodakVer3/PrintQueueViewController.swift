//
//  PrintQueueViewController.swift
//  KodakVer3
//
//  Created by jmolas on 3/14/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintQueueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ButtonCellDelegate{
    
    enum PrintStatus : String{
        case Waiting = "Waiting..."
        case Processing = "Processing... (Page 1/1)"
    
    }
    
    @IBOutlet weak var printJobs: UITableView!

    var images2 = [UIImage]()
      
    
    
    var printData = [PrintData]()
    var buttonId = [Int]()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
        if timer2 != nil{
            timer2.invalidate()
            print("invadidated")
        }
        
        print("view didDisappear")
    }
   
    var cell : PrintQueueTableViewCell!
    var separatorHeight: CGFloat = 1.5
    
    
    var target : Float = 100
    var step : Float = 0
    var currentCounter : Int!
    private let separatorID = 124
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        printJobs.delegate = self
        printJobs.dataSource = self
        printJobs.allowsSelection = false
        //printJobs.backgroundColor = .black
        self.printJobs.backgroundColor = .black
        self.printJobs.tableFooterView = UIView(frame: .zero)
        self.printJobs.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: printJobs.frame.width, height: separatorHeight))
        self.printJobs.tableHeaderView?.backgroundColor = .lightGray
        self.printJobs.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: printJobs.frame.width, height: separatorHeight))
        self.printJobs.tableFooterView?.backgroundColor = .lightGray
       
        
    }
    var timer: Timer!
    var timer2: Timer!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //runProgressOnFirstRow()
        fireProgressBar()
      
        
    }
    
    func fireProgressBar(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startProgress), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func startProgress(){
        
     
        step += 10
        if step <= target{
           
            if let ips = printJobs.indexPathsForVisibleRows{
                for i in 0..<ips.count{
                    if ips[i].row == 0{
                        //
                        let cell = printJobs.cellForRow(at: ips[i]) as! PrintQueueTableViewCell
                        cell.progressView.progress = step / 100.0
                        if cell.statusNPages.text == PrintStatus.Waiting.rawValue{
                            cell.statusNPages.text = PrintStatus.Processing.rawValue
                        }
                    }
                }
            }
            
        }
        if step > target{
            //endProgress()
            printComplete()
            step = 0
        }
    }
    

    func printComplete(){
        
        printJobs.beginUpdates()
        printData.remove(at: 0)
        printJobs.deleteRows(at: [IndexPath.init(row: 0, section: 0)], with: .bottom)
        printJobs.endUpdates()
        
        if printData.count == 0{
            timer.invalidate()
            donePrinting()
        }
       
    
    }
    
    var customButton : UIImageView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PrintQueueTableViewCell", owner: self, options: nil)?.first as! PrintQueueTableViewCell

        if cell.buttonDelegate == nil{
            cell.buttonDelegate = self
        }
        cell.imageThumbNail.image = printData[indexPath.row].thumbNail
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateNTime = dateFormatter.date(from: "\(year)-\(month)-\(day) \(hour)-\(minutes)-\(seconds)")
        //cell.dateNTime.text = "\(year)/\(month)/\(day) \(hour):\(minutes):\(seconds)"
        let dateString = dateFormatter.string(from: dateNTime!)
        cell.dateNTime.text = dateString
        cell.statusNPages.text = PrintStatus.Waiting.rawValue
   
        
            
        return cell
        
    }
    
    func buttonTapped(cell: PrintQueueTableViewCell){
       
            if let ip = printJobs.indexPath(for: cell){
                printJobs.beginUpdates()
                
                if ip.row == 0{
                    printData.remove(at: ip.row)
                    printJobs.deleteRows(at: [ip], with: .bottom)
                    if printData.count == 0{
                        timer.invalidate()
                        donePrinting()
                                            }
                    printJobs.endUpdates()
                    step = 0.0
                    
                }else{
                    printData.remove(at: ip.row)
                    printJobs.deleteRows(at: [ip], with: .bottom)
                    printJobs.endUpdates()
                }
                
            }

    }
    
    private func donePrinting(){
        self.perform(#selector(close), with: nil, afterDelay: 4.0)
    }

 
    func close(){
        let vc = self.navigationController as! MyNavController
        vc.pop()
    }
    
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printData.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

