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
    
    var container: UIView!
    var line: UIView!
    var title: UILabel!
    var tableView: UITableView!
    var cancel: UIButton!
    
    private let margin: CGFloat = 10.0
    var width: CGFloat!
    var height: CGFloat!
    var currentPrinter: Int?
    
    var delegate: PrinterSelectDelegate?
   
    
    var printerList: [String] = []{
        didSet {
          
            height = CGFloat(computeHeight(numberOfItems: printerList.count) * 44)
          
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = frame.width * 0.9
        setupViews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.frame = CGRect(x: container.frame.minX, y: container.frame.minY, width: width, height: 44.0)
        line.frame = CGRect(x: container.frame.minX, y: title.frame.maxY, width: width, height: 3.0)
        tableView.frame = CGRect(x: container.frame.minX, y: line.frame.maxY, width: width, height: height)
        
        cancel.frame = CGRect(x: container.frame.minX, y: tableView.frame.maxY, width: width, height: 44.0)
        
        
        container.frame = CGRect(x: 0, y: 0, width: width, height: title.frame.height + line.frame.height + tableView.frame.height + cancel.frame.height)
        container.center = convert(center, from: self)
        container.layer.cornerRadius = 10
        
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        self.addSubview(container)
        
        title = UILabel(frame: .zero)
        title.textAlignment = .center
        title.text = "Select Printer"
   //     title.textColor = UIColor(red: 57/255, green: 63/255, blue: 203/255, alpha: 1.0)
        title.textColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0)

        
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(title)
        
        line = UIView(frame: .zero)
        line.backgroundColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(line)
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(tableView)
        
        cancel = UIButton(frame: .zero)
        
        cancel.setTitleColor(UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1.0), for: .normal)
        cancel.setTitle("Cancel", for: .normal)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.addTarget(self, action: #selector(dismissView(_ :)), for: .touchUpInside)
        container.addSubview(cancel)
        
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
