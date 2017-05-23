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
    
    func toOrderPattern() -> OrderPattern {
        switch self {
        case .special:
            return .special
        case .shared:
            return .shared
        case .expressage:
            return .expressage
        case .longJourney:
            return .longJourney
        default:
            return .special
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
    
    init( _ index: Int) {
        switch index {
        case 0:
            self = .special
        case 1:
            self = .expressage
        case 2:
            self = .shared
        default:
            self = .longJourney
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
