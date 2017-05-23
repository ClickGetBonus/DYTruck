//
//  GetNearAutoApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/22.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork

class GetNearAutoApi: DYBaseRequest, DYRequest {
    
    typealias Response = GetNearAutosResponse
    
    var city: String = ""
    var range: Int = 0
    var lat: Double = 0.0
    var lon: Double = 0.0
    var type: OrderPattern = .special
    
    init(city: String,
         range: Int,
         lat: Double,
         lon: Double,
         type: OrderPattern) {
        self.city = city
        self.range = range
        self.lat = lat
        self.lon = lon
        self.type = type
        super.init()
    }
    
    override func requestUrl() -> String {
        return "api/service/nearAuto"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["city"] = city
        param["range"] = range
        param["lat"] = lat
        param["lon"] = lon
        switch self.type {
        case .expressage:
            param["type"] = 2
        default:
            param["type"] = 1
        }
        return param
    }
    
}
