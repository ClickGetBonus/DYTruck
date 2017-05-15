//
//  OrderInfoVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class OrderInfoVC: UIViewController {
    
    struct CellParameters {
        let section: Int
        let rowCount: [Int]
        let cellIdentifier:[[String]]
        let rowHeight: [[CGFloat]]
    }
    
    @IBOutlet weak var tableView: UITableView!
    let cellParameter: CellParameters =
        CellParameters(section: 5,
                       rowCount: [1, 4, 1, 1, 1],
                       cellIdentifier: [[InfoProgressCell.className],
                                        [OrderIntroCell.className, OrderAddressCell.className, OrderAddressCell.className, OrderAddressCell.className],
                                        [InfoDriverCell.className],
                                        [SpecialOrderInfoCell.className],
                                        [InfoPaymentCell.className]],
                       rowHeight: [[InfoProgressCell.cellHeight],
                                   [OrderIntroCell.cellHeight, OrderAddressCell.cellHeight, OrderAddressCell.cellHeight, OrderAddressCell.cellHeight],
                                   [InfoDriverCell.cellHeight],
                                   [0],
                                   [InfoPaymentCell.cellHeight]])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "订单详情"
        self.setupBackItem()
        self.initSubviews()
    }
    
    func initSubviews() {
        
        self.tableView.register(InfoProgressCell.nib, forCellReuseIdentifier: InfoProgressCell.className)
        self.tableView.register(OrderIntroCell.nib, forCellReuseIdentifier: OrderIntroCell.className)
        self.tableView.register(OrderAddressCell.nib, forCellReuseIdentifier: OrderAddressCell.className)
        self.tableView.register(InfoDriverCell.nib, forCellReuseIdentifier: InfoDriverCell.className)
        self.tableView.register(SpecialOrderInfoCell.nib, forCellReuseIdentifier: SpecialOrderInfoCell.className)
        self.tableView.register(InfoPaymentCell.nib, forCellReuseIdentifier: InfoPaymentCell.className)
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
           
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let progressCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InfoProgressCell
        progressCell.startAnima()
    }
    
    func configure(_ pattern: OrderPattern, state: OrderState) {
        
    }
    
    
    
}

extension OrderInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cellParameter.section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellParameter.rowCount[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.cellParameter.rowHeight[indexPath.section][indexPath.row]
        if height == 0 {
            
            return tableView.fd_heightForCell(withIdentifier: SpecialOrderInfoCell.className, configuration: { (cell) in
                let specialCell = cell as! SpecialOrderInfoCell
                specialCell.configure("首上岛咖啡坚实的反馈和第三方付款了京东方李会计法考虑你俩的事开发觉得上课了富家大室妇女快捷键")
            })
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = self.cellParameter.cellIdentifier[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        switch cellIdentifier {
        case OrderAddressCell.className:
            let addressCell = cell as! OrderAddressCell
            addressCell.selectionStyle = .none
            if indexPath.row == 1 {
                addressCell.configure(.location, address: "天河区棠安路188号 乐天大厦")
            } else if indexPath.row == 2 {
                addressCell.configure(.approach, address: "天河区棠安路188号 乐天大厦")
            } else if indexPath.row == 3 {
                addressCell.configure(.destination, address: "天河区棠安路188号 乐天大厦")
            }
        default:
            break;
        }
        return cell!
    }
}


