//
//  MyOrderVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/21.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class MyOrderVC: UIViewController {

    var patterns: [Pattern] = [Pattern.all, Pattern.specialCar, Pattern.shareingCar, Pattern.espressage, Pattern.longJourney]
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var patternView: PatternSelectView!
    var scrollTableView = TLScrollTableView(frame: CGRect.zero,
                                            viewCount: 0,
                                            tableViewInsets: UIEdgeInsets.zero,
                                            style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor.white),
                                                                    for: .any,
                                                                    barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.patternView.itemWidthConstraint.constant = self.view.width/5
        
    }

    func initSubviews() {
        
        self.setupBackItem()
        
        //        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
        //
        //        })
        
        
        self.patternView.patterns = patterns
        self.patternView.selectCallBack = { self.scrollTableView.scrollTo($0) }
        
        
        scrollTableView = TLScrollTableView(frame: CGRect(x: 0,
                                                          y: 40,
                                                          width: self.view.width,
                                                          height: self.view.height - 40),
                                            viewCount: 5,
                                            tableViewInsets: UIEdgeInsets.zero,
                                            style: .grouped)
        scrollTableView.backgroundColor = UIColor.groupTableViewBackground
        scrollTableView.tableViewDelegate = self
        scrollTableView.tableViewDataSource = self
        self.view.addSubview(scrollTableView)
        scrollTableView.selectionCallBack = { self.patternView.selectPattern(self.patterns[$0]) }
        
        for i in 0 ... 4 {
            scrollTableView.configure(index: i) {
                $0.register(UINib(nibName: OrderCell.className, bundle: nil), forCellReuseIdentifier: OrderCell.className)
                $0.tableFooterView = UIView(frame: CGRect.zero)
                $0.rowHeight = 200.0
                $0.separatorStyle = .none
            }
        }
        scrollTableView.updateViews()
        
    }
    
    @IBAction func segmentValueDidChanged(_ sender: UISegmentedControl) {
        
    }
    
    func onClickEvaluate() {
        
    }
}

// MARK: - UITableView
extension MyOrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.className) as! OrderCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
