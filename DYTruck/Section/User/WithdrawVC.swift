//
//  WithdrawVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/27.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class WithdrawVC: UITableViewController {

    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var accountTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        let confirmButton = UIButton(frame: CGRect(x: self.view.width/2-135, y: 430, width: 270, height: 45))
        confirmButton.setTitle("确定申请", for: .normal)
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.backgroundColor = kRGBColorFromHex(0x333333)
        confirmButton.layer.cornerRadius = 22.5
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        self.view.addSubview(confirmButton)
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func onConfirm() {
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            accountTextField.becomeFirstResponder()
        }
    }
}
