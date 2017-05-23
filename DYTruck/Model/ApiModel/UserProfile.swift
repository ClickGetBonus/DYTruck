//
//  UserProfile.swift
//  DYTruck
//
//  Created by Lan on 2017/5/21.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import HandyJSON

struct UserProfile: HandyJSON {
    
    var id: String = ""
    var avatar: String = ""
    var phone: String = ""
    var nickname: String = ""
    var sex: String = ""
    var idnumber: String = ""
    var realname: String = ""
    var status: Int?
}
