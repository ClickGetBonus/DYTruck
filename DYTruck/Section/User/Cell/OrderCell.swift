//
//  OrderCell.swift
//  DYTruck
//
//  Created by Lan on 17/4/24.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var patternLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var startPlaceLabel: UILabel!
    
    @IBOutlet weak var destinationPlaceLabel: UILabel!
    @IBOutlet weak var ContactLabel: UILabel!
    
    @IBOutlet weak var seperator: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.seperator.setBackgroundImage(UIImage(color: UIColor.groupTableViewBackground), for: .normal)
    }
    
    func configure(with entity: NSObject) {
        
    }
}
