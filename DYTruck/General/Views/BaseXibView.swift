//
//  BaseXibView.swift
//  DYTruck
//
//  Created by Lan on 17/4/16.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

@objc class BaseXibView: UIView {

    
    var contentView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.bounds
    }
    
    func loadView() {
        if self.contentView != nil {
            return
        }
        self.contentView = self.loadViewWithNibName(self.xibName, owner: self)
        self.contentView.frame = self.bounds
        self.contentView.backgroundColor = UIColor.clear
        self.addSubview(self.contentView)
    }
}
