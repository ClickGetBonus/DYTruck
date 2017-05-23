//
//  GetUserProfileApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/21.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork

class GetUserProfileApi: DYBaseRequest, DYRequest {
    
    typealias Response = GetUserProfileResponse
    
    var token: String?
    var userid: String?
    
    init(token: String, userid: String) {
        self.token = token
        self.userid = userid
        super.init()
    }
    
    override func requestUrl() -> String {
        return "api/account/getProfile"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .GET
    }
    
    override func requestArgument() -> Any? {
        var param = super.requestArgument() as! [String: Any]
        param["token"] = token
        param["userid"] = userid
        return param
    }
    
}
