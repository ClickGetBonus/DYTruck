//
//  GoodsEditCell.swift
//  DYTruck
//
//  Created by Lan on 2017/5/11.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class GoodsEditCell: UITableViewCell {
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    let buttonHeight: CGFloat = 26
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var quantityButton: UIButton!
    
    @IBOutlet weak var nameButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var weightButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var volumeButtonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var quantityButtonLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    let typeSequence: [GoodsParameterType] = [.name, .weight, .volume, .quantity]
    
    let leftPadding: CGFloat = 16
    let buttonPadding: CGFloat = 8
    let buttonHorizontalEdge: CGFloat = 20
    
    override func awakeFromNib() {
         super.awakeFromNib()
        
    }
    
    
    func updateBy(parameters: [GoodsParameterType: String]) {
        
//        let rec = UITapGestureRecognizer { _ in
//            self.setSelected(true, animated: true)
//        }
//        self.scrollView.addGestureRecognizer(rec)
        self.scrollView.isUserInteractionEnabled = false
        
        self.placeHolderLabel.isHidden = false
        
        let buttons: [UIButton] = [nameButton, weightButton, volumeButton, quantityButton]
        let constraints: [NSLayoutConstraint] = [nameButtonLeftConstraint, weightButtonLeftConstraint, volumeButtonLeftConstraint, quantityButtonLeftConstraint]
        
        for type in typeSequence {
            let button = buttons[typeSequence.index(of: type)!]
            let constraint = constraints[typeSequence.index(of: type)!]
            
            guard parameters[type] != nil && parameters[type]?.isEmpty == false else {
                button.isHidden = true
                if type == .name {
                    constraint.constant = buttonPadding - buttonHorizontalEdge
                } else {
                    constraint.constant = -buttonHorizontalEdge
                }
                continue
            }
            self.placeHolderLabel.isHidden = true
            
            
            button.isHidden = false
            if type == .name {
                constraint.constant = leftPadding
            } else {
                constraint.constant = buttonPadding
            }
            
            
            let value = parameters[type]!
            switch type {
            case .name:
                button.setTitle(value, for: .normal)
            case .weight:
                button.setTitle("\(value)Kg", for: .normal)
            case .volume:
                button.setTitle("\(value)m³", for: .normal)
            case .quantity:
                button.setTitle("\(value)件", for: .normal)
            }
        }
        self.contentView.layoutSubviews()
        self.scrollView.contentSize = CGSize(width: quantityButton.right + 20, height: self.contentView.bounds.height)
        self.scrollView.isHidden = !self.placeHolderLabel.isHidden
    }
}
