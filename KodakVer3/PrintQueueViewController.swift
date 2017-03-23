//
//  PrintQueueViewController.swift
//  KodakVer3
//
//  Created by jmolas on 3/14/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class PrintQueueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var printJobs: UITableView!
    //    let cancelButton: UIButton = {
    //        let button = UIButton(type: .custom)
    //        button.setBackgroundImage(#imageLiteral(resourceName: "job_cancel"), for: .normal)
    //
    //        return button
    //
    //    }()
    var images2 = [UIImage]()
    
    
    var target : Int!
    var step : Int!
    var currentCounter : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printJobs.delegate = self
        printJobs.dataSource = self
        printJobs.allowsSelection = false
        print("viewDidload_PQ")
        
    }
    var timer: Timer!
    override func viewDidAppear(_ animated: Bool) {
        target = 20
        step = 2
        currentCounter = 0
        
//        DispatchQueue.global().sync(execute: {
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doWork), userInfo: nil, repeats: true)
//            timer.fire()
//        })
        
        //        DispatchQueue.global(qos: .default).async {
        //            self.doWork()
        //        }
        
        
    }
    
    func doWork(){
        //let ip = IndexPath(item: 0, section: 0)
        
        if images2.count == 0{
            timer.invalidate()
        }
        
        if currentCounter < target{
            
            currentCounter =  currentCounter + step
            print(currentCounter)
            
        }else{
            
            images2.remove(at: 0)
            printJobs.reloadData()
            currentCounter = 0
            doWork()
            
            
        }
        
    }
    
    func updateUI(){
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "printJobCell", for: indexPath)
        
        let iv = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "job_cancel")
        iv.tag = indexPath.row

        iv.isUserInteractionEnabled = true
        
        //iv.addGestureRecognizer()
        let imgView = cell.contentView.viewWithTag(123) as! UIImageView
        imgView.image = images2[indexPath.row]
        print("cellforrowat_PQ \(iv.tag)")
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeCell(sender:))))
        
        cell.accessoryView = iv
    
    
        return cell
        
    }
    func removeCell(sender: UITableViewCell){
        
        print("any \(sender.accessibilityValue)")
//        for i in 0..<images2.count{
//            if sender.tag == i{
//                print(sender.tag)
//            }
//        }
//        if let i = printJobs.indexPathForSelectedRow?.row{
//            images2.remove(at: i)
//            printJobs.deleteRows(at: [IndexPath.init(row: i, section: 0)], with: .fade)
//            printJobs.reloadData()
//        }
        
        //print("called \(sender.de)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images2.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

