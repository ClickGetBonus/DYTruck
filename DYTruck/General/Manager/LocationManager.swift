//
//  LocationManager.swift
//  DYTruck
//
//  Created by Lan on 2017/5/21.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

class LocationManager {
    
    static var address: Address {
        set {
            let string = newValue.toJSONString()
            UserDefaults.standard.set(string, forKey: "address")
        }
        
        get {
            let string = UserDefaults.standard.string(forKey: "address")
            return Address.deserialize(from: string) ?? Address()
        }
    }
    
    static var locationCity: City {
        set {
            UserDefaults.standard.set(newValue.toJSONString(), forKey: "locationCity")
        }
        
        get {
            let string = UserDefaults.standard.string(forKey: "locationCity")
            return City.deserialize(from: string) ?? City(id: "d410262-4668-4b3f-82aa-d9f5696a1964",
                                                          utime: nil,
                                                          service_type: 1,
                                                          province: "广东省",
                                                          ctime: nil,
                                                          order_mark: "GZ",
                                                          city: "广州市")
        }
    }
    
    static var location: CLLocationCoordinate2D {
        set {
            UserDefaults.standard.set(newValue.latitude, forKey: "latitude")
            UserDefaults.standard.set(newValue.longitude, forKey: "longitude")
        }
        
        get {
            return CLLocationCoordinate2D(latitude: UserDefaults.standard.double(forKey: "latitude"),
                                          longitude: UserDefaults.standard.double(forKey: "longitude"))
        }
    }
    
    static func addRecentlyPOI( _ poi: MapPOI) {
        
        var pois: [MapPOI] = self.recentlyPOI
        
        
        for (i, p) in pois.enumerated() {
            if p.uid! == poi.uid! {
                let temp = pois.remove(at: i)
                pois.insert(temp, at: 0)
                self.recentlyPOI = pois
                return
            }
        }
        
        if pois.count > 15 {
            pois.removeLast()
        }
        
        pois.insert(poi, at: 0)
        self.recentlyPOI = pois
    }
    
    static var recentlyPOI: [MapPOI] {
        set {
            let jsonString = newValue.toJSONString()
            UserDefaults.standard.set(jsonString, forKey: "recentlyPOI")
        }
        
        get {
            if let string = UserDefaults.standard.string(forKey: "recentlyPOI") {
                return [MapPOI].deserialize(from: string) as! [MapPOI]
            } else {
                return []
            }
        }
    }
}
