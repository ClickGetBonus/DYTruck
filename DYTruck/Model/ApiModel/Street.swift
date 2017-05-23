//
//  Street.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON

struct Street: HandyJSON {
    var street: String? //街道名
    var number: String? //门牌号
    var latitude: Double?
    var longitude: Double?
    var distance: Int?  //距离
    var direction: String? //方向
}

//
/////街道名称
//@property (nonatomic, copy)   NSString     *street;
/////门牌号
//@property (nonatomic, copy)   NSString     *number;
/////坐标点
//@property (nonatomic, copy)   AMapGeoPoint *location;
/////距离（单位：米）
//@property (nonatomic, assign) NSInteger     distance;
/////方向
//@property (nonatomic, copy)   NSString     *direction;
