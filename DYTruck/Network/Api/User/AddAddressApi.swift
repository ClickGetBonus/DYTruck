//
//  AddAddressApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/20.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import YTKNetwork

class AddAddressApi: DYBaseRequest, DYRequest {
    
    typealias Response = DYResponse
    
    var token: String?
    var province: String?
    var city: String?
    var district: String?
    var street: String?
    var address: String?
    var lat: CGFloat?
    var lon: CGFloat?
    
    init(token: String,
         province: String,
         city: String,
         district: String,
         street: String,
         address: String,
         lat: CGFloat,
         lon: CGFloat) {
        
        self.token = token
        self.province = province
        self.city = city
        self.district = district
        self.street = street
        self.address = address
        self.lat = lat
        self.lon = lon
        super.init()
    }
    
    
    override func requestUrl() -> String {
        return "api/account/addAddress"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["token"] = token
        param["province"] = province
        param["city"] = city
        param["district"] = district
        param["street"] = street
        param["address"] = address
        param["lat"] = lat
        param["lon"] = lon
        return param
    }
    
}
