//
//  City.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON

struct City: HandyJSON {
    
    var id: String?
    var utime: String?
    var service_type: Int?
    var province: String?
    var ctime: String?
    var order_mark: String?
    var city: String?
    
    static func changeToTLCity( _ citys :[City]) -> [TLCity] {
        var results: [TLCity] = []
        for city in citys {
            let tlcity = TLCity()
            tlcity.cityID = city.id!
            tlcity.cityName = city.city!
            tlcity.pinyin = city.order_mark!
            tlcity.initials = String(city.order_mark!.characters.first!)
            results.append(tlcity)
        }
        return results
    }

}
