//
//  UserManager.swift
//  DYTruck
//
//  Created by Lan on 2017/5/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


class UserManager {
    
    
    static var authentication: Authentication {
        set {
            UserDefaults.standard.set(newValue.toJSONString(), forKey: "authentication")
        }
        
        get {
            let string = UserDefaults.standard.string(forKey: "authentication")
            return Authentication.deserialize(from: string) ?? Authentication()
        }
    }
    
    
    static var isLogin: Bool {
        return self.authentication.token != nil && !self.authentication.token!.isEmpty
    }
    
    
    static var userProfile: UserProfile {
        set {
            UserDefaults.standard.set(newValue.toJSONString(), forKey: "userProfile")
        }
        get {
            let string = UserDefaults.standard.string(forKey: "userProfile")
            return UserProfile.deserialize(from: string) ?? UserProfile()
        }
    }
    
    
}
