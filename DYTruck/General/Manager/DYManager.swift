//
//  DYManager.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


class DYManager {
    
    static var citys: [City] {
        set {
            UserDefaults.standard.set(newValue.toJSONString(), forKey: "citys")
        }
        
        get {
            let string = UserDefaults.standard.string(forKey: "citys")
            return [City].deserialize(from: string) as? [City] ?? []
        }
    }
    
}
