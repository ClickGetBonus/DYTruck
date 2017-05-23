//
//  MyAddressApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/21.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import YTKNetwork

class MyAddressApi: DYBaseRequest, DYRequest {
    
    typealias Response = MyAddressResponse
    
    var token: String?
    
    init(token: String) {
        self.token = token
        super.init()
    }
    
    override func requestUrl() -> String {
        return "api/account/myAddress"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["token"] = token
        return param
    }

}
