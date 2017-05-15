//
//  DYResponse.swift
//  DYTruck
//
//  Created by Lan on 2017/5/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

protocol Decodable {
    static func parse(data: String?) -> Self?
}

class DYResponse : Decodable, HandyJSON {
    
    var code: Int = 0
    var message: String?
    
    required init() {}
    
    static func parse(data: String?) -> Self? {
        if data == nil || data!.isEmpty {
            return nil
        }
        
        if let object = self.deserialize(from: data) {
            return object
        }
        return nil
    }
}
