//
//  RegistApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork

class RegistApi: DYBaseRequest, DYRequest {
    
    typealias Response = RegistResponse
    
    let phone: String
    let password: String
    let code: String
    
    init(phone: String, password: String, code: String) {
        self.phone = phone
        self.password = password
        self.code = code
        super.init()
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["phone"] = self.phone
        param["password"] = self.password
        param["code"] = self.code
        param["type"] = 2
        return param
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestUrl() -> String {
        return "api/account/register"
    }
    
    
}
