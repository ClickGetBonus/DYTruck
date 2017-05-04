//
//  MessageVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/20.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import MJRefresh

class MessageVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "消息"
        self.initSubViews()
    }
    
    func initSubViews() {
        
        self.setupBackItem()
        
        self.tableView.register(UINib(nibName: MessageCell.className, bundle: nil), forCellReuseIdentifier: MessageCell.className)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
//        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
//            
//        })
        
    }
    
}


// MARK: - UITableView
extension MessageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.className) as! MessageCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "通知消息"
            cell.subTitleLabel.text = "滴约送货更新V1.2版本"
            cell.dateLabel.text = "2017-01-09"
            cell.leftImageView.image = UIImage(named: "g_scg_icn")
        } else {
            cell.titleLabel.text = "订单消息"
            cell.subTitleLabel.text = "你有一笔专车订单已经完成, 及时评价可获得积分"
            cell.dateLabel.text = "2017-01-02"
            cell.leftImageView.image = UIImage(named: "g_sc_icn")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}
