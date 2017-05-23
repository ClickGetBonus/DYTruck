//
//  ConstantMacro.swift
//  DYTruck
//
//  Created by Lan on 17/4/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation

let GDMapKey = "0a8ae4cd10e95cab807498bed182eac4"

let DYBaseURL = "http://diyue.lucius.cn/"
let DYRequestTimeoutInterval: TimeInterval = 15.0

let DYHudPresentationInterval: TimeInterval = 1.8

func DLog<T>(_ message: T,
          file: String = #file,
          method: String = #function,
          line: Int = #line)
{
    #if DEBUG
        print("\(method): \(message)")
    #endif
}
