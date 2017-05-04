//
//  BalanceVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/25.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class BalanceVC: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var rechargeButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var withdrawButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        self.rechargeButton.layer.cornerRadius = self.rechargeButton.height/2
        self.rechargeButton.layer.masksToBounds = true
        
        self.infoButton.addCornerBorder(kRGBColorFromHex(0x4d4d4d), 1)
        self.withdrawButton.addCornerBorder(kRGBColorFromHex(0x4d4d4d), 1)
        
    }

}
