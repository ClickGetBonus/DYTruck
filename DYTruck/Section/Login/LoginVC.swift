//
//  LoginVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    
    var loginCompleteBehavior: () -> Void = {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubViews()
        
        self.setupBackItem(target: self, selector: #selector(goMain))
    }
    
    func goMain() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func initSubViews() {
        
        phoneView.layer.borderColor = kRGBColorFromHex(0xc8c8c8).cgColor
        phoneView.layer.borderWidth = 1.0
        phoneView.layer.cornerRadius = phoneView.frame.height/2
        
        pwView.layer.borderColor = kRGBColorFromHex((0xc8c8c8)).cgColor
        pwView.layer.borderWidth = 1.0
        pwView.layer.cornerRadius = pwView.frame.height/2
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }
    
    
    
    @IBAction func onLogin(_ sender: Any) {
        
        guard let phone = self.phoneTextField.text.guardEmptyWith(msg: "请输入手机号码") else
        { return }
        
        guard let passwprd = self.pwTextField.text.guardEmptyWith(msg: "请输入手机号码") else
        { return }
        
        
        let loginApi = LoginApi(phone: phone, password: passwprd.MD5())
        loginApi.startWithCompletionBlock(success: { (request) in
            
            let loginResponse = LoginApi.Response.parse(data: request.responseString)!
            DLog("\(String(describing: loginResponse.data?.token))")
            
            
            UserManager.authentication = Authentication(token: loginResponse.data?.token,
                                                        userid: loginResponse.data?.userid)
            
            self.getUserProfile()
        }) { (request) in
            
        }
    }
    
    func getUserProfile() {
        
        let profileApi = GetUserProfileApi(token: UserManager.authentication.token!, userid: UserManager.authentication.userid!)
        profileApi.startWithCompletionBlock(success: { (request) in
            
            let response: GetUserProfileResponse = GetUserProfileApi.Response.parse(data: request.responseString)!
            let profile = response.data!
            
            UserManager.userProfile = profile
            self.navigationController?.dismiss(animated: true,
                                               completion: self.loginCompleteBehavior)
            
        }) { (request) in
            UserManager.authentication = Authentication()
        }
    }
}


// MARK: - Button Action
extension LoginVC {
    
    
    
    
    
}
