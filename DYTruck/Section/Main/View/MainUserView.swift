//
//  MainUserView.swift
//  DYTruck
//
//  Created by Lan on 17/4/19.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import Kingfisher

class MainUserView: BaseXibView {
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var avatarCallBack: () -> Void = {}
    var orderCallBack: () -> Void = {}
    var walletCallBack: () -> Void = {}
    var serviceCallBack: () -> Void = {}
    var settingCallBack: () -> Void = {}
    
    var userProfile: UserProfile = UserManager.userProfile
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarButton.kf.setImage(with: URL(string: userProfile.avatar), for: .normal)
        self.nameLabel.text = userProfile.nickname
    }
    
    
    @IBAction func onClickAvatar(_ sender: Any) {
        self.avatarCallBack()
    }
    
    @IBAction func onClickOrder(_ sender: Any) {
        self.orderCallBack()
    }
    
    @IBAction func onClickWallet(_ sender: Any) {
        self.walletCallBack()
    }
    
    @IBAction func onClickService(_ sender: Any) {
        self.serviceCallBack()
    }
    
    @IBAction func onClickSetting(_ sender: Any) {
        self.settingCallBack()
    }
}
