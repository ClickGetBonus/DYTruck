//
//  DYAddress.swift
//  DYTruck
//
//  Created by Lan on 2017/5/21.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON

struct DYAddress: HandyJSON {
    
    
    var province: String?
    var city: String?
    var district: String?
    var address: String?
    var street: String?
    var lat: CGFloat?
    var lon: CGFloat?
}
