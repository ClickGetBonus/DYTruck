//
//  MapPOI.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON

struct MapPOI: HandyJSON {
    
    var uid: String?
    var name: String?
    var type: String?
    var typecode: String?
    var address: String?
    var tel: String?
    var distance: Int?
    var parkingType: String?
    var shopID: String?
    var postcode: String?
    var website: String?
    var email: String?
    var province: String?
    var pcode: String?
    var city: String?
    var citycode: String?
    var district: String?
    var adcode: String?
    var gridcode: String?
    var latitude: CGFloat?
    var longitude: CGFloat?
    
    
    
    init() {}
    
    init(_ poi: AMapPOI) {
        self.uid = poi.uid
        self.name = poi.name
        self.type = poi.type
        self.typecode = poi.typecode
        self.latitude = poi.location.latitude
        self.longitude = poi.location.longitude
        self.address = poi.address
        self.tel = poi.tel
        self.distance = poi.distance
        self.parkingType = poi.parkingType
        self.shopID = poi.shopID
        self.postcode = poi.postcode
        self.website = poi.website
        self.email = poi.email
        self.province = poi.province
        self.pcode = poi.pcode
        self.city = poi.city
        self.citycode = poi.citycode
        self.district = poi.district
        self.adcode = poi.adcode
        self.gridcode = poi.gridcode
    }
}
