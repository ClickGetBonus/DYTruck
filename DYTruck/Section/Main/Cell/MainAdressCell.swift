//
//  MainAdressCell.swift
//  DYTruck
//
//  Created by Lan on 17/4/17.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class MainAdressCell: UITableViewCell {
    
    
    
    @IBOutlet weak var indicator: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var rightButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var seperator: UIButton!
    
    private var _isShowIndicator: Bool = false
    var isShowIndicator: Bool {
        set {
            let width: CGFloat = newValue ? 32 : 0
            self.rightButtonWidthConstraint.constant = width
            //            _isShowIndicator = newValue
        }
        get {
            return _isShowIndicator
        }
    }
    
    var rightButtonBehavior: (MainAdressCell) -> Void = { _ in }
    
    enum Style {
        case departure
        case departureAdd
        case destination
    }
    var style: Style = .departure {
        didSet {
            
            switch style {
            case .departure:
                self.textField.placeholder = "请输入您的货物所在地"
                self.indicator.setBackgroundImage(UIImage(color: kRGBColorFromHex(0x0080FF)),
                                                  for: .normal)
                self.isShowIndicator = true
                self.rightButton.setImage(UIImage(named: "wd_tj_icn"), for: .normal)
            case .departureAdd:
                self.textField.placeholder = "请输入您的货物所在地"
                self.indicator.setBackgroundImage(UIImage(color: kRGBColorFromHex(0x0080FF)),
                                                  for: .normal)
                self.isShowIndicator = true
                self.rightButton.setImage(UIImage(named: "wd_qx_icn"), for: .normal)
            case .destination:
                self.textField.placeholder = "请输入您的货物目的地"
                self.indicator.setBackgroundImage(UIImage(color: UIColor.red),
                                                  for: .normal)
                self.isShowSeperator = false
                self.rightButton.setImage(UIImage(named: "wd_tj_icn"), for: .normal)
            }
        }
    }
    
    
    private var _isShowSeperator: Bool = true
    var isShowSeperator: Bool {
        set {
            self.seperator.isHidden = !newValue
        }
        get {
            return _isShowSeperator
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedBackgroundView = UIView(frame: self.contentView.bounds)
        selectedBackgroundView.backgroundColor = UIColor.groupTableViewBackground
        selectedBackgroundView.alpha = 0.8
        self.selectedBackgroundView = selectedBackgroundView;
        
        self.seperator.setBackgroundImage(UIImage(color: UIColor.groupTableViewBackground), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    @IBAction func onRightButton(_ sender: Any) {
        self.rightButtonBehavior(self)
    }
    
}
