//
//  StringUtil.swift
//  DYTruck
//
//  Created by Lan on 2017/5/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import SVProgressHUD

extension String {
    func guardEmptyWith(msg: String) -> Bool {
        
        if self.isEmpty {
            SVProgressHUD.show(withStatus: msg)
            SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            return true
        }
        
        return false
    }
}

extension Optional where Wrapped == String {
    
    func guardEmptyWith(msg: String) -> String? {
        
        if self == nil || self!.isEmpty {
            SVProgressHUD.showError(withStatus: msg)
            SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            return nil
        }
        
        return self
    }
}

//MARK: - MD5
extension Int
{
    func hexedString() -> String
    {
        return NSString(format:"%02x", self) as String
    }
}

extension NSData
{
    func hexedString() -> String
    {
        var string = String()
        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
        for i in UnsafeBufferPointer<UInt8>(start:unsafePointer, count: length)
        {
            string += Int(i).hexedString()
        }
        return string
    }
    func MD5() -> NSData
    {
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
        return NSData(data: result as Data)
    }
}

extension String
{
    func MD5() -> String
    {
        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
        return data.MD5().hexedString()
    }
}
