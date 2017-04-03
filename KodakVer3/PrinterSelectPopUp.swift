//
//  PrinterSelectPopUp.swift
//  KodakVer3
//
//  Created by jmolas on 2/7/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

protocol PrinterSelectDelegate {
    func select(index: Int)
}



class PrinterSelectPopUp: UIView, UITableViewDelegate, UITableViewDataSource{
    
   
    
    private let margin: CGFloat = 10.0
    private var width: CGFloat!
    private var height: CGFloat!
    var currentPrinter: Int?
    
    var delegate: PrinterSelectDelegate?
   
    
    var printerList: [String] = []{
        didSet {
            
            height = CGFloat(computeHeight(numberOfItems: printerList.count)) * 44.0
        
            addViews()
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = frame.width * 0.9
     
        
    }
    func addViews(){
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height + 88.0))
        self.addSubview(containerView)
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 44.0))
        title.text = "Select Printer"
        title.numberOfLines = 1
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .aqua
        title.backgroundColor = .white
        title.textAlignment = .center
        containerView.addSubview(title)
        
        let line = UIView(frame: CGRect(x: 0, y: title.frame.maxY, width: width, height: 1.5))
        line.backgroundColor = .aqua
        containerView.addSubview(line)
        
        let table = UITableView(frame: CGRect(x: 0, y: line.frame.maxY, width: width, height: height))
        table.delegate = self
        table.dataSource = self
        containerView.addSubview(table)
        
        let cancel = UILabel(frame: CGRect(x: 0, y: table.frame.maxY, width: width, height: 44.0))
        cancel.text = "Cancel"
        cancel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelSelect)))
        cancel.isUserInteractionEnabled = true
        cancel.numberOfLines = 1
        cancel.minimumScaleFactor = 0.5
        cancel.adjustsFontSizeToFitWidth = true
        cancel.textColor = .aqua
        cancel.textAlignment = .center
        cancel.backgroundColor = .white
        containerView.addSubview(cancel)
        
        
        containerView.center = convert(center, from: self)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    func cancelSelect(){
        self.removeFromSuperview()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func dismissView(_ sender: UIButton){
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.select(index: indexPath.row)
        self.removeFromSuperview()
    }
    
 
    
    func computeHeight(numberOfItems: Int) ->Int{
        if numberOfItems > 5 {
            return 5
        }else{
            return numberOfItems
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printerList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        if (currentPrinter == indexPath.row){
            let check = UIImageView(image: #imageLiteral(resourceName: "checkmark_list"))
            check.contentMode = .scaleAspectFit
            check.frame = CGRect(x: cell.contentView.frame.maxX, y:cell.contentView.frame.minY, width: cell.contentView.frame.height, height: cell.contentView.frame.height)
            cell.contentView.addSubview(check)
        
        }
        
        
        cell.textLabel?.text = printerList[indexPath.row]
    
       
        return cell
    }
    
   

}
