//
//  WalletVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/25.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class WalletVC: UITableViewController {
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var cardNumLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
}
