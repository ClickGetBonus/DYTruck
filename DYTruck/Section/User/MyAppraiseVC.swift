//
//  MyAppraiseVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/24.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class MyAppraiseVC: UIViewController {
    
    
    
    var scrollTableView: TLScrollTableView?
    let selectView = SelectView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.currentBounds().width,
                                              height: 40),
                                selections: ["我收到的评论", "我发出的评论"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    func initSubviews() {
        
        self.setupBackItem()
        
        self.selectView.selectedCallBack = {
            self.scrollTableView?.scrollTo($0)
        }
        
        view.addSubview(self.selectView)
        
        
        
        scrollTableView = TLScrollTableView(frame: CGRect(x: 0,
                                                          y: 40,
                                                          width: self.view.width,
                                                          height: self.view.height - 40),
                                            viewCount: 2,
                                            tableViewInsets: UIEdgeInsets(top: 5,
                                                                          left: 5,
                                                                          bottom: 0,
                                                                          right: 5),
                                            style: .grouped)
        scrollTableView?.backgroundColor = UIColor.groupTableViewBackground
        scrollTableView!.tableViewDelegate = self
        scrollTableView!.tableViewDataSource = self
        self.view.addSubview(scrollTableView!)
        scrollTableView?.selectionCallBack = { self.selectView.selectIndex = $0 }
        
        scrollTableView?.configure(index: 0) {
            $0.register(AppraiseCell.nib, forCellReuseIdentifier: AppraiseCell.className)
            $0.estimatedRowHeight = 150.0
            $0.rowHeight = UITableViewAutomaticDimension
            $0.separatorStyle = .none
        }
        
        scrollTableView?.configure(index: 1) {
            $0.register(AppraiseCell.nib, forCellReuseIdentifier: AppraiseCell.className)
            $0.estimatedRowHeight = 150.0
            $0.rowHeight = UITableViewAutomaticDimension
            $0.separatorStyle = .none
        }
        
        scrollTableView?.updateViews()
    }
    
}


// MARK: - UITableView
extension MyAppraiseVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppraiseCell.className) as! AppraiseCell
        cell.configure(with: nil)
        if indexPath.section == 0 {
            cell.contentLabel.text = "真的谢谢王师傅, 原本我们拖延了一点点时间结果王师傅还是准时帮我送到了. 王师傅好样的"
        } else {
            cell.contentLabel.text = "态度很好, 期待下次合作"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
