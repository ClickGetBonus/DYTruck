//
//  Address.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON


struct Address: HandyJSON {
    
    var province: String?
    var city: String?
    var citycode: String?
    var district: String?
    var adcode: String?
    var township: String?
    var towncode: String?
    var neighborhood: String?
    var building: String?
    var street: Street?
}
