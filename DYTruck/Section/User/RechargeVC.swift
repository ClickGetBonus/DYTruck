//
//  RechargeVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/25.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class RechargeVC: UITableViewController {
    
    @IBOutlet weak var weixinCell: UITableViewCell!
    @IBOutlet weak var zfbCell: UITableViewCell!
    
    @IBOutlet weak var accountTextField: UITextField!
    
    var rechargeSelection = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        
        let confirmButton = UIButton(frame: CGRect(x: self.view.width/2-135, y: 350, width: 270, height: 45))
        confirmButton.setTitle("确定充值", for: .normal)
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.backgroundColor = kRGBColorFromHex(0x333333)
        confirmButton.layer.cornerRadius = 22.5
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        self.view.addSubview(confirmButton)
    }
    
    func onConfirm() {
        if self.rechargeSelection == 0 {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            self.accountTextField.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            self.rechargeSelection = 1
            weixinCell.accessoryType = .checkmark
            zfbCell.accessoryType = .none
        } else if indexPath.section == 1 && indexPath.row == 1 {
            zfbCell.accessoryType = .checkmark
            self.rechargeSelection = 2
            weixinCell.accessoryType = .none
        }
    }
}

