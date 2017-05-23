//
//  AddressCell.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    
    enum AddressType {
        case recently
        case search
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    func configure(title: String, subTitle: String, type: AddressType) {
        self.titleLabel.text = title
        self.subTitleLabel.text = title
        
        switch type {
        case .recently:
            self.leftImageView.image = UIImage(named: "home_ddo_icn")
        case .search:
            self.leftImageView.image = UIImage(named: "home_ddo_icn")
        }
    }
}
