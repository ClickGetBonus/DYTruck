//
//  PatternSelectView.swift
//  DYTruck
//
//  Created by Lan on 17/4/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class PatternSelectView: BaseXibView {
    
    @IBOutlet weak var itemWidthConstraint: NSLayoutConstraint!
    
    var selectCallBack: (Int) -> Void = { _ in }
    var patterns: [Pattern] = [] {
        didSet {
            for (i, pattern) in patterns.enumerated() {
                let button = self.buttons[i]
                button.setTitle(pattern.name, for: .normal)
            }
        }
    }
    
    
    private var selectedIndex: Int = 0
    private let buttonCount = 5
    
    
    
    var selectedPattern: Pattern {
        switch self.selectedIndex {
        case 0:
            return Pattern.specialCar
        case 1:
            return Pattern.espressage
        case 2:
            return Pattern.shareingCar
        case 3:
            return Pattern.longJourney
        case 4:
            return Pattern.storage
        default:
            return Pattern.all
        }
    }
    
    func setButtonPattern(_ patterns: [Pattern]) {
        for (index, pattern) in patterns.enumerated() {
            let button = self.viewWithTag(index+1) as! UIButton
            button.setTitle(pattern.name, for: .normal)
        }
    }
    
    
    lazy var buttons: [UIButton] = {
        var result: [UIButton] = []
        for i in 0 ..< self.buttonCount {
            let button = self.viewWithTag(i+1)
            result.append(button as! UIButton)
        }
        return result
    }()
    
    
    func selectPattern(_ p: Pattern) {
        for (i, pattern) in self.patterns.enumerated() {
            if pattern == p {
                selectIndex(i)
            }
        }
    }
    
    private func selectIndex(_ i: Int) {
        
        for button in buttons {
            button.setTitleColor(kRGBColorFromHex(0x666666), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        
        let button = buttons[i]
        button.setTitleColor(kRGBColorFromHex(0xf6a224), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.selectedIndex = i
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        
        selectIndex(sender.tag-1)
        self.selectCallBack(sender.tag-1)
    }
    
    
}
