//
//  LoginApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/16.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork

class LoginApi: DYBaseRequest, DYRequest {
    
    typealias Response = LoginResponse
    
    var phone: String?
    var password: String?
    
    init(phone: String, password: String) {
        self.phone = phone
        self.password = password
        super.init()
    }
    
    override func requestUrl() -> String {
        return "api/account/login"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["type"] = 2
        param["phone"] = self.phone
        param["password"] = self.password
        return param
    }
}
