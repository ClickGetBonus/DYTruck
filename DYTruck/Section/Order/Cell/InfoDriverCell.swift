//
//  InfoDriverCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import EDStarRating

class InfoDriverCell: UITableViewCell {
    
    
    static let cellHeight: CGFloat = 140
    var telephoneBehavior: () -> Void = {}
    var chatBehavior: () -> Void = {}
    var locationBehavior: () -> Void = {}
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var starView: EDStarRating!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var plateNumberLabel: UILabel!
    
    @IBOutlet weak var truckTypeLabel: UILabel!
    @IBOutlet weak var truckModelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starView.starImage = UIImage(named: "grzx_dj_02")
        starView.starHighlightedImage = UIImage(named: "grzx_dj_01")
        starView.maxRating = 5
        starView.rating = 4
        starView.editable = false
        starView.horizontalMargin = 0
        starView.displayMode = 2
    }
    
    @IBAction func onTelephone(_ sender: Any) {
        telephoneBehavior()
    }
    
    @IBAction func onChat(_ sender: Any) {
        chatBehavior()
    }
    
    @IBAction func onLocation(_ sender: Any) {
        locationBehavior()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
