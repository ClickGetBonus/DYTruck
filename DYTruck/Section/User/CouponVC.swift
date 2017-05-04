//
//  CouponVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/25.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class CouponVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        self.tableView.register(CouponCell.nib, forCellReuseIdentifier: CouponCell.className)
        self.tableView.sectionFooterHeight = 5.0
        self.tableView.sectionHeaderHeight = 1.0
    }
}


extension CouponVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponCell.className) as! CouponCell
        if indexPath.section == 0 {
            cell.couponImageView.image = UIImage(named: "yhq_01")
            cell.usingImageView.isHidden = true
        } else {
            cell.couponImageView.image = UIImage(named: "yhq_02")
            cell.usingImageView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}


