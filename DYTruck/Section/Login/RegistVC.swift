//
//  RegistVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegistVC: UIViewController {
    
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var verifyView: UIView!
    @IBOutlet weak var pwView: UIView!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var verifyTextField: UITextField!
    
    @IBOutlet weak var getCodeButton: UIButton!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var timer: Timer = Timer()
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
    }
    
    func configureSubViews() {
        
        phoneView.addCornerBorder(kRGBColorFromHex(0xc8c8c8), 1.0)
        verifyView.addCornerBorder(kRGBColorFromHex(0xc8c8c8), 1.0)
        pwView.addCornerBorder(kRGBColorFromHex(0xc8c8c8), 1.0)
        
        nextButton.layer.cornerRadius = nextButton.height/2
    }
    
    func updateCountDown() {
        
        if count <= 0 {
            self.getCodeButton.setTitle("获取验证码", for: .normal)
            self.getCodeButton.setTitleColor(kRGBColorFromHex(0xf6a224), for: .normal)
            
            self.getCodeButton.isUserInteractionEnabled = true
            timer.invalidate()
        } else {
            self.getCodeButton.setTitle("\(count)s", for: .normal)
            self.getCodeButton.setTitleColor(UIColor.lightGray, for: .normal)
            self.getCodeButton.isUserInteractionEnabled = false
            count -= 1
        }
    }
    
    @IBAction func onGetCode(_ sender: Any) {
        
        //TODO Get Code
        count = 5
        timer = Timer(timeInterval: 1.0,
                      target: self,
                      selector: #selector(updateCountDown),
                      userInfo: nil,
                      repeats: true)
        timer.fire()
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    
    @IBAction func onNextStep(_ sender: Any) {
        
        guard let phone = self.phoneTextField.text.guardEmptyWith(msg: "请输入手机号码") else {return}
        guard let code = self.verifyTextField.text.guardEmptyWith(msg: "请输入验证码") else {return}
        guard let password = self.pwTextField.text.guardEmptyWith(msg: "请输入密码") else {return}
        
        let registApi = RegistApi(phone: phone, password: password.MD5(), code: code)
        registApi.isShowHud = true
        registApi.startWithCompletionBlock(success: { (request) in
            
            let response = RegistApi.Response.parse(data: request.responseString)
            DLog(response?.data?.token)
            self.navigationController?.popViewController(animated: true)
            
            SVProgressHUD.showInfo(withStatus: "注册成功")
            SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
        }) { (request) in
            
        }
        
    }
    
    
    
}
