//
//  NearAuto.swift
//  DYTruck
//
//  Created by Lan on 2017/5/22.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON

struct NearAuto: HandyJSON {
    var user_id: String?
    var lat: Double?
    var lon: Double?
    var distance: Int?
    var auto_name: String?
}
