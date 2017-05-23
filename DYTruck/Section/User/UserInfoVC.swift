//
//  UserInfoVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/22.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userInfo: UserProfile = UserManager.userProfile
    
    @IBOutlet weak var addressBackgroundView: UIView!
    @IBOutlet weak var passwordBackgroundView: UIView!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userSexAccountLabel: UILabel!
    @IBOutlet weak var userIdentifierLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackItem()
        self.addressBackgroundView.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        self.addressBackgroundView.layer.borderWidth = 1.0
        self.passwordBackgroundView.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        self.passwordBackgroundView.layer.borderWidth = 1.0
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userInfo = UserManager.userProfile
        self.configure()
    }
    
    func configure() {
        self.userAvatarImageView.kf.setImage(with: )
    }
    
    
    @IBAction func onEditAddress(_ sender: Any) {
    }
    
    @IBAction func onEditPassword(_ sender: Any) {
    }
    
    @IBAction func onEditUserInfo(_ sender: Any) {
        self.performSegue(withIdentifier: "goUserEdit", sender: nil)
    }
    
}
