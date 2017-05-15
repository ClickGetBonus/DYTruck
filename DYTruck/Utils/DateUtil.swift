//
//  DateUtil.swift
//  DYTruck
//
//  Created by Lan on 2017/5/11.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


extension Date {
    
    func stringWith(format: String) -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
    func dateWith(string: String, format: String) -> Date? {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.date(from: string)
    }
}
