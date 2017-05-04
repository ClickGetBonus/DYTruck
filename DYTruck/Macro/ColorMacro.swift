//
//  ColorMacro.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import UIKit

func kRGBColorFromHex(_ rgbValue: Int) -> UIColor {
    
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}
