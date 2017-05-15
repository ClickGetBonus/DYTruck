//
//  OrderAddressCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/6.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class OrderAddressCell: UITableViewCell {

    enum Style {
        case location
        case approach
        case destination
    }
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    static let cellHeight: CGFloat = 50
    
    func configure( _ style: Style, address: String?) {
        switch style {
        case .location:
            self.leftImageView.image = UIImage(named: "ty_dd_icn")
            self.textField.placeholder = "请输入您的货物所在地"
        case .approach:
            self.leftImageView.image = UIImage(named: "ty_dd_04")
            self.textField.placeholder = "请输入您的货物途径地"
        case .destination:
            self.leftImageView.image = UIImage(named: "ty_dv_icn")
            self.textField.placeholder = "请输入您的货物目的地"
        }
        
        self.textField.text = address
    }
}
