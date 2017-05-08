//
//  OrderLinkmanCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/5.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit


@IBDesignable class OrderLinkmanCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBInspectable var name: String? {
        set {
            self.nameLabel.text = newValue
        }
        get {
            return self.nameLabel.text
        }
    }
    
    @IBInspectable var phone: String? {
        set {
            self.phoneLabel.text = newValue
        }
        get {
            return self.phoneLabel.text
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
