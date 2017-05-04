//
//  LoginVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubViews()
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
        
    }

    @IBAction func onRegist(_ sender: Any) {
        
    }
    
    @IBAction func onForget(_ sender: Any) {
        
    }
    
}


// MARK: - Button Action
extension LoginVC {
    
    
    
    
    
}
