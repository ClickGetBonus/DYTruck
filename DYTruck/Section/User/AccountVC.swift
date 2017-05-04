//
//  AccountVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/26.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    
    @IBOutlet weak var tableView3: UITableView!
    
    let selectView = SelectView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.currentBounds().width,
                                              height: 40),
                                selections: ["订单", "充值", "全部"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupBackItem()
        
        initSubviews()
    }
    
    func initSubviews() {
        
        
        
        self.scrollView.contentSize = CGSize(width: self.view.width*3,
                                             height: self.scrollView.height)
//        self.scrollView.isPagingEnabled = true
        
        self.selectView.selectedCallBack = { index in
            self.scrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.width, y:0),
                                             animated: true)
        }
        self.view.addSubview(self.selectView)
        
        
        tableView1.register(AccountOrderCell.nib, forCellReuseIdentifier: AccountOrderCell.className)
        tableView2.register(AccountRechargeCell.nib, forCellReuseIdentifier: AccountRechargeCell.className)
        tableView3.register(AccountOrderCell.nib, forCellReuseIdentifier: AccountOrderCell.className)
        tableView3.register(AccountRechargeCell.nib, forCellReuseIdentifier: AccountRechargeCell.className)
        
        tableView1.tableFooterView = UIView(frame: CGRect.zero)
        tableView2.tableFooterView = UIView(frame: CGRect.zero)
        tableView3.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension AccountVC: UIScrollViewDelegate {
    
    
}

extension AccountVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === tableView1 {
            let cell = tableView1.dequeueReusableCell(withIdentifier: AccountOrderCell.className) as! AccountOrderCell
            return cell
        } else if tableView === tableView2 {
            let cell = tableView2.dequeueReusableCell(withIdentifier: AccountRechargeCell.className) as! AccountRechargeCell
            return cell
        } else {
            if indexPath.row%2 == 0 {
                let cell = tableView1.dequeueReusableCell(withIdentifier: AccountOrderCell.className) as! AccountOrderCell
                return cell
            } else {
                let cell = tableView2.dequeueReusableCell(withIdentifier: AccountRechargeCell.className) as! AccountRechargeCell
                return cell
            }
        }
    }
    
}
