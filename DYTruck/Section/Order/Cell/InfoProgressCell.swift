//
//  InfoProgressCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import HorizontalProgress

class InfoProgressCell: UITableViewCell {

    @IBOutlet weak var progressView: HorizontalProgressView!
    static let cellHeight:CGFloat = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        progressView.unachievedColor = kRGBColorFromHex(0x666666)
//        progressView.achievedColor = UIColor.green
        progressView.lineMaxHeight = 6
        progressView.pointMaxRadius = 6
        progressView.progressLevelArray = ["等待接单", "司机接单", "开始发货", "送货完成"]
        progressView.textPosition = .bottomPosition
        progressView.currentLevel = 1
        progressView.animationDuration = 1.0
    }
    
    func startAnima() {
        progressView.startAnimation()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
