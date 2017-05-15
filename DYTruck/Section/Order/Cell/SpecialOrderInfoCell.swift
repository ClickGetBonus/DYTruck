//
//  SpecialOrderInfoCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class SpecialOrderInfoCell: UITableViewCell {

    @IBOutlet weak var usingTimeLabel: UILabel!
    @IBOutlet weak var truckTypeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var extNeedLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure( _ text: String) {
        self.remarkLabel.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
