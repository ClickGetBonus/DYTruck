//
//  DashedBorderView.swift
//  DYTruck
//
//  Created by Lan on 2017/5/6.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
class DashedBorderView: UIView {
    
    var _border: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        _border = CAShapeLayer();
        
        _border.strokeColor = UIColor.white.cgColor
        _border.fillColor = nil;
        _border.lineDashPattern = [4, 4];
        self.layer.addSublayer(_border);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius:8).cgPath;
        _border.frame = self.bounds;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _border = CAShapeLayer();
        
        _border.strokeColor = UIColor.white.cgColor
        _border.fillColor = nil;
        _border.lineDashPattern = [4, 4];
        self.layer.addSublayer(_border);
    }
}
