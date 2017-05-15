//
//  DYEnum.swift
//  DYTruck
//
//  Created by Lan on 17/4/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


enum Pattern {
    case special
    case expressage
    case shared
    case longJourney
    case storage
    case all
    
    
    var name: String {
        switch self {
        case .special:
            return "专车"
        case .expressage:
            return "快递"
        case .shared:
            return "拼车"
        case .longJourney:
            return "长途"
        case .storage:
            return "仓储"
        case .all:
            return "全部"
        }
    }
}

enum OrderPattern {
    case special
    case expressage
    case shared
    case longJourney
    
    var name: String {
        switch self {
        case .special:
            return "专车"
        case .expressage:
            return "快递"
        case .shared:
            return "拼车"
        case .longJourney:
            return "长途"
        }
    }
}

enum OrderState {
    case waitReceiving
    case deiverReceived
    case sendingGoods
    case completeSend
}

enum TimePattern {
    case now
    case order
}


enum GoodsParameterType {
    case name
    case weight
    case volume
    case quantity
}
