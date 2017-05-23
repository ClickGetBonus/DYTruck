//
//  GetAutosApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/22.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork

class GetAutosApi: DYBaseRequest, DYRequest {
    
    typealias Response = GetAutosResponse
    
    var city: String = ""
    var type: OrderPattern = .special
    
    init(city: String, type: OrderPattern) {
        self.city = city
        self.type = type
        super.init()
    }
    
    override func requestUrl() -> String {
        return "api/service/autos"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["city"] = city
        switch self.type {
        case .expressage:
            param["type"] = 2
        default:
            param["type"] = 1
        }
        return param
    }
    
}
