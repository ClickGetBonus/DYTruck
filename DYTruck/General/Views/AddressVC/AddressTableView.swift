//
//  AddressTableView.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class AddressTableView: UITableView {
    
    
    fileprivate var searchKey: String? = nil
    
    var selectedCallBack: (String) -> Void = { _ in }
    var showRecently: Bool = true {
        didSet {
            self.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.loadView()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        self.register(AddressCell.nib, forCellReuseIdentifier: AddressCell.className)
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = UIColor.white
    }
    
    func setSearchKey( _ key: String?) {
        
        self.showRecently = ((key == nil || key!.isEmpty) ? true : false)
        self.searchKey = key
    }
    
    
    
//    var contentView: UIView!
//    //MAKR: - Init
//    override init(frame: CGRect, style: UITableViewStyle) {
//        super.init(frame: frame, style: style)
//        self.loadView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.loadView()
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.contentView.frame = self.bounds
//    }
//    
//    func loadView() {
//        if self.contentView != nil {
//            return
//        }
//        self.contentView = self.loadViewWithNibName(self.xibName, owner: self)
//        self.contentView.frame = self.bounds
//        self.contentView.backgroundColor = UIColor.clear
//        self.addSubview(self.contentView)
//    }
}



extension AddressTableView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showRecently {
            return 2
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showRecently {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.className) as! AddressCell
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "搜索 \(self.searchKey!) 的结果"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        if showRecently {
            let cell = tableView.cellForRow(at: indexPath) as! AddressCell
            selectedCallBack((cell.titleLabel.text)!)
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            selectedCallBack((cell?.textLabel?.text)!)
        }
    }
}
