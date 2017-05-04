//
//  DYEnum.swift
//  DYTruck
//
//  Created by Lan on 17/4/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


enum Pattern {
    case specialCar
    case espressage
    case shareingCar
    case longJourney
    case storage
    case all
    
    
    var name: String {
        switch self {
        case .specialCar:
            return "专车"
        case .espressage:
            return "快递"
        case .shareingCar:
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

enum TimePattern {
    case now
    case order
}
