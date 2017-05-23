//
//  DYListRequest.swift
//  DYTruck
//
//  Created by Lan on 2017/5/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork


class DYListRequest: DYBaseRequest {
    
    //分页
    var pageSize: Int = 10
    var isPaging = false
    var page: Int = 0
    
}
