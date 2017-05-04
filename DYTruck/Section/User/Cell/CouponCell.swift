//
//  CouponCell.swift
//  DYTruck
//
//  Created by Lan on 17/4/25.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {

    @IBOutlet weak var couponImageView: UIImageView!
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var usingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
    }
    
    
}
