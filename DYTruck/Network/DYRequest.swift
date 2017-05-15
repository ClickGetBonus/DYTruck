//
//  DYRequest.swift
//  DYTruck
//
//  Created by Lan on 2017/5/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork
import SVProgressHUD

protocol DYRequest {
    
    func requestMethod() -> YTKRequestMethod
    
    func requestUrl() -> String
    
    func requestArgument() -> Any?
    
    associatedtype Response: Decodable
}
