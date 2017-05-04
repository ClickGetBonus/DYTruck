//
//  MainInfoView.swift
//  DYTruck
//
//  Created by Lan on 17/4/18.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class MainInfoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        infoLabel.size = frame.size
        secondInfoLabel.size = frame.size
        backgroundView.size = frame.size
        secondInfoLabel.top = frame.height + frame.origin.y
        
        initSubviews()
    }
    
    
    open func addInformation( _ info: NSAttributedString) {
        infoQueue.append(info)
        nextInfo()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var infoLabel = UILabel()
    private var secondInfoLabel = UILabel()
    private let backgroundView = UIView()
    private var infoQueue: [NSAttributedString] = []
    
    
    private func initSubviews() {
        
        self.clipsToBounds = true
        
        self.backgroundColor = UIColor.clear
        
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.4
        self.backgroundView.layer.cornerRadius = 7.0
        self.backgroundView.layer.masksToBounds = true
        
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        secondInfoLabel.font = UIFont.systemFont(ofSize: 18)
        infoLabel.textAlignment = .center
        secondInfoLabel.textAlignment = .center
        infoLabel.textColor = UIColor.white
        secondInfoLabel.textColor = UIColor.white
        
        addSubview(backgroundView)
        addSubview(infoLabel)
        addSubview(secondInfoLabel)
    }
    
    
    
    private func nextInfo() {
        
        let topLabel = infoLabel.top < secondInfoLabel.top ? infoLabel : secondInfoLabel
        let bottomLabel = infoLabel.top > secondInfoLabel.top ? infoLabel : secondInfoLabel
        
        topLabel.transitionOut(UIOffset(horizontal: 0, vertical: -50)) {
            topLabel.top = self.height
        }
        
        if let info = infoQueue.first {
            bottomLabel.attributedText = info
            bottomLabel.frame = self.bounds
            bottomLabel.transitionIn(UIOffset(horizontal: 0, vertical: 50)) {
                
            }
        }
    }
    
}
