//
//  AppraiseCell.swift
//  DYTruck
//
//  Created by Lan on 17/4/24.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import EDStarRating

class AppraiseCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var starView: EDStarRating!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        starView.starImage = UIImage(named: "grzx_dj_02")
        starView.starHighlightedImage = UIImage(named: "grzx_dj_01")
        starView.maxRating = 5
        starView.rating = 4
        starView.editable = false
        starView.horizontalMargin = 0
        starView.displayMode = 2
    }

    
    func configure(with entity: NSObject?) {
        
        
    }
}
