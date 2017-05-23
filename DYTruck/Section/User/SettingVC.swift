//
//  SettingVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/27.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import SVProgressHUD

class SettingVC: UITableViewController {
    
    var logoutBehavior: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
    }
    
    func initSubviews() {
        
        self.setupBackItem()
        
        self.navigationController?.navigationBar.shadowImage = nil
        
        
        let logoutButton = UIButton(frame: CGRect(x: self.view.width/2-135, y: 420, width: 270, height: 45))
        logoutButton.setTitle("退出登录", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.backgroundColor = kRGBColorFromHex(0x333333)
        logoutButton.layer.cornerRadius = 22.5
        logoutButton.layer.masksToBounds = true
        logoutButton.addTarget(self, action: #selector(onLogout), for: .touchUpInside)
        self.view.addSubview(logoutButton)
    }
    
    func onLogout() {
        
        UserManager.authentication = Authentication()
        logoutBehavior()
        self.navigationController?.popViewController(animated: true)
        
        SVProgressHUD.showInfo(withStatus: "注销成功")
        SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
    }
}
