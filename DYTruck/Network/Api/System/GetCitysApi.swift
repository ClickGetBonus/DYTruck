//
//  GetCitysApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork

class GetCitysApi: DYBaseRequest, DYRequest {
    
    typealias Response = GetCitysResponse
    
    var pattern: OrderPattern
    
    init(pattern: OrderPattern) {
        self.pattern = pattern
        super.init()
    }
    
    override func requestUrl() -> String {
        return "api/service/cities"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        var value = 1
        switch self.pattern {
        case .expressage:
            value = 2
        default:
            value = 1
        }
        param["type"] = value
        return param
    }
    
}
