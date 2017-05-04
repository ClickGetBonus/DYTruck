//
//  SelectView.swift
//  DYTruck
//
//  Created by Lan on 17/4/24.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class SelectView: UIView {
    
    
    var deselectFontSize: CGFloat = 16
    var selectFontSize: CGFloat = 18
    var selectColor: UIColor = kRGBColorFromHex(0xf6a224)
    var deselectColor: UIColor = kRGBColorFromHex(0x666666)
    var selectedBackgroundColor: UIColor = UIColor.white
    var deselectedBackgroundColor: UIColor = UIColor.white
    
    
    
    required init(frame: CGRect, selections: [String]) {
        super.init(frame: frame)
        self.selections = selections
        self.reloadViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var selectedCallBack: (Int) -> Void = {_ in }
    
    var selectIndex: Int = 0 {
        didSet {
            self.updateViews()
        }
    }
    
    var count: Int {
        return selections.count
    }
    
    func addSelections( _ strings: [String]) {
        for string in selections {
            self.addSelection(string)
        }
        self.reloadViews()
    }
    
    func addSelection( _ string: String) {
        self.selections.append(string)
        self.reloadViews()
    }
    
    
    private var selections: [String] = [] {
        didSet {
            self.reloadViews()
        }
    }
    private var items: [UIButton] = []
    
    
    func reloadViews() {
        
        self.removeAllSubviews()
        self.items.removeAll()
        
        let width = self.width / CGFloat(self.count)
        for (i, selection) in selections.enumerated() {
            
            let button = UIButton()
            button.frame = CGRect(x: CGFloat(i) * width,
                                  y: 0,
                                  width: width,
                                  height: self.height)
            button.setTitle(selection, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: deselectFontSize)
            button.setTitleColor(deselectColor, for: .normal)
            button.setBackgroundImage(UIImage(color: deselectedBackgroundColor), for: .normal)
            button.setBackgroundImage(UIImage(color: deselectedBackgroundColor), for: .highlighted)
            button.addTarget(self, action: #selector(itemDidSelected), for: .touchUpInside)
            button.tag = i
            self.addSubview(button)
            self.items.append(button)
            
            if i == selectIndex {
                button.setTitleColor(selectColor, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: selectFontSize)
                button.setBackgroundImage(UIImage(color: selectedBackgroundColor), for: .normal)
                button.setBackgroundImage(UIImage(color: selectedBackgroundColor), for: .highlighted)
            }
        }
    }
    
    func updateViews() {
        for (i, selection) in selections.enumerated() {
            
            let button = items[i]
            button.setTitle(selection, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: deselectFontSize)
            button.setTitleColor(deselectColor, for: .normal)
            button.setBackgroundImage(UIImage(color: deselectedBackgroundColor), for: .normal)
            button.setBackgroundImage(UIImage(color: deselectedBackgroundColor), for: .highlighted)
            
            if i == selectIndex {
                button.setTitleColor(selectColor, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: selectFontSize)
                button.setBackgroundImage(UIImage(color: selectedBackgroundColor), for: .normal)
                button.setBackgroundImage(UIImage(color: selectedBackgroundColor), for: .highlighted)
            }
        }

    }
    
    func itemDidSelected( _ item: UIButton) {
        
        self.selectIndex = item.tag
        self.updateViews()
        
        self.selectedCallBack(item.tag)
    }

}
