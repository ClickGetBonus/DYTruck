//
//  TLScrollTableView.swift
//  DYTruck
//
//  Created by Lan on 17/4/27.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class TLScrollTableView: UIScrollView {
    
    var viewCount = 0
    var selectionCallBack: (Int) -> Void = { _ in}
    var tableViews: [UITableView] = []
    var tableViewInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var tableViewStyle: UITableViewStyle = .plain
    var tableViewDelegate: UITableViewDelegate?
    var tableViewDataSource: UITableViewDataSource?
    
    
    func configure(index: Int, for handler: (UITableView) -> Void) {
        handler(self.tableViews[index])
    }
    
    required init(frame: CGRect, viewCount: Int, tableViewInsets: UIEdgeInsets, style: UITableViewStyle) {
        super.init(frame: frame)
        self.viewCount = viewCount
        self.tableViewStyle = style
        self.tableViewInsets = tableViewInsets
        self.isPagingEnabled = true
        self.delegate = self
        self.reloadViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func scrollTo(_ index: Int) {
        
        self.scrollRectToVisible(CGRect(x: self.width * CGFloat(index),
                                        y: 0,
                                        width: self.width,
                                        height: self.height),
                                 animated: true)
        self.selectIndex = index
    }
    
    var selectIndex: Int = 0 {
        didSet {
            self.selectionCallBack(selectIndex)
        }
    }
    
    var selectedTableView: UITableView {
        return tableViews[selectIndex]
    }
    
    func reloadViews() {
        
        self.removeAllSubviews()
        self.tableViews.removeAll()
        
        let width = self.width - tableViewInsets.left - tableViewInsets.right
        let height = self.height - tableViewInsets.top - tableViewInsets.bottom
        for i in 0 ..< viewCount {
            let tableView = UITableView(frame: CGRect(x: tableViewInsets.left + (CGFloat(i) * self.width),
                                                      y: tableViewInsets.top,
                                                      width: width,
                                                      height: height),
                                        style: self.tableViewStyle)
            tableView.delegate = self.tableViewDelegate
            tableView.dataSource = self.tableViewDataSource
            tableView.tag = i
            self.addSubview(tableView)
            
            self.tableViews.append(tableView)
        }
        
        self.contentSize = CGSize(width: CGFloat(viewCount) * self.width,
                                  height: self.height)
    }
    
    func updateViews() {
        for view in tableViews {
            view.delegate = self.tableViewDelegate
            view.dataSource = self.tableViewDataSource
            view.reloadData()
        }
    }
    
    
}

extension TLScrollTableView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.selectIndex = Int(scrollView.contentOffset.x / self.width)
    }
}
