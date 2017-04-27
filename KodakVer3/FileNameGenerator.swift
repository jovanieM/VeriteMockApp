//
//  FileNameGenerator.swift
//  KodakVer3
//
//  Created by jmolas on 4/19/17.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class FileNameGenerator: NSObject{
    
    func generateFileName() ->String{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd_HH:mm:ss"
        let dateNTime = dateFormatter.date(from: "\(year)-\(month)-\(day)_\(hour)-\(minutes)-\(seconds)")
        
        let dateAsFileName = dateFormatter.string(from: dateNTime!).stringByRemovingAll(characters: ["/", ":"])
        return dateAsFileName
    }


}
