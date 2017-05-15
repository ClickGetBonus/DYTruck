//
//  InfoPaymentCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class InfoPaymentCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 120
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sendPriceLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
