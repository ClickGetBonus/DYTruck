//
//  UserEditVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/22.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import ImagePicker
import SVProgressHUD

class UserEditVC: UIViewController {
    
    
    @IBOutlet weak var userAvatarButton: UIButton!
    
    @IBOutlet weak var nickNameBackgroundView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var sexBackgroundView: UIView!
    @IBOutlet weak var sexButtonFemale: UIButton!
    @IBOutlet weak var sexButtonMale: UIButton!
    var sexSelection: Int = 0 {
        didSet {
            if sexSelection == 0 {
                sexSelection = 0
                self.sexButtonMale.setImage(UIImage(named: "grzx_bg_02"), for: .normal)
                self.sexButtonFemale.setImage(UIImage(named: "grzx_bg_01"), for: .normal)
            } else if sexSelection == 1 {
                sexSelection = 1
                self.sexButtonMale.setImage(UIImage(named: "grzx_bg_01"), for: .normal)
                self.sexButtonFemale.setImage(UIImage(named: "grzx_bg_02"), for: .normal)
            } else {
                sexSelection = 2
                self.sexButtonMale.setImage(UIImage(named: "grzx_bg_02"), for: .normal)
                self.sexButtonFemale.setImage(UIImage(named: "grzx_bg_02"), for: .normal)
            }
        }
    }
    
    var userInfo: UserProfile = UserManager.userProfile
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackItem()
        
        self.nickNameBackgroundView.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        self.nickNameBackgroundView.layer.borderWidth = 1.0
        self.sexBackgroundView.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        self.sexBackgroundView.layer.borderWidth = 1.0
        
        self.configure()
    }
    
    func configure() {
        self.userAvatarButton.kf.setImage(with: URL(string: userInfo.avatar), for: .normal)
        self.nickNameTextField.text = self.userInfo.nickname
        
        let sex = self.userInfo.sex
        if !sex.isEmpty {
            if sex == "男" {
                self.sexSelection = 1
            } else if sex == "女" {
                self.sexSelection = 2
            } else {
                self.sexSelection = 0
            }
        }
    }
    
    @IBAction func onClickAvatar(_ sender: Any) {
        Configuration.doneButtonTitle = "完成"
        Configuration.noImagesTitle = "您的相册还没有图片"
        Configuration.recordLocation = false
        Configuration.OKButtonTitle = "确认"
        Configuration.noCameraTitle = "相机不可用"
        Configuration.settingsTitle = "设置"
        Configuration.requestPermissionMessage = "请允许嘀约访问您的相册"
        
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageLimit = 1
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onClickSex(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        self.sexSelection = tag
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        
    }
}

extension UserEditVC: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        guard images.count > 0 else {
            SVProgressHUD.showError(withStatus: "请至少选择一张图片")
            SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            return
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        let api = UploadImageApi(images: [images.first!])
        api.startWithCompletionBlock(success: { (request) in
            
            SVProgressHUD.showInfo(withStatus: "上传头像成功")
            SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            
            self.userAvatarButton.setImage(images.first!, for: .normal)
            
        }) { (request) in
            
        }
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
}
