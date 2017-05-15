//
//  OrderIntroCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class OrderIntroCell: UITableViewCell {

    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    static let cellHeight: CGFloat = 75
    
    func configure(orderNum: String, timeString: String) {
        orderNumLabel.text = orderNum
        timeLabel.text = timeString
    }
}
