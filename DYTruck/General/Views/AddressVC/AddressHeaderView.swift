//
//  AddressHeaderView.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class AddressHeaderView: BaseXibView, UITextFieldDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    
    var cancelCallBack: () -> Void = { }
    var selectCallBack: () -> Void = { }
    var editCallBack: (String?) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        addressTextField.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textChange(_ textField: UITextField) {
        self.editCallBack(textField.text)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.cancelCallBack()
    }
    
    @IBAction func onSelectCity(_ sender: Any) {
        self.selectCallBack()
    }
    
    
}
