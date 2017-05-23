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
    
    var recentlyPOI: [MapPOI] = LocationManager.recentlyPOI
    
    var pois: [MapPOI] = [] {
        didSet {
            self.showRecently = (pois.count == 0 ? true : false)
            self.reloadData()
        }
    }
    
    var selectedCallBack: (MapPOI) -> Void = { _ in }
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
        self.tableFooterView = UIView(frame: CGRect.zero)
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
            return self.recentlyPOI.count
        } else {
            return self.pois.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showRecently {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.className) as! AddressCell
            let poi: MapPOI = self.recentlyPOI[indexPath.row]
            cell.titleLabel.text = poi.name
            cell.subTitleLabel.text = poi.address
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.className) as! AddressCell
            let poi = pois[indexPath.row]
            cell.titleLabel.text = poi.name
            cell.subTitleLabel.text = poi.address
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if showRecently {
            selectedCallBack(self.recentlyPOI[indexPath.row])
            LocationManager.addRecentlyPOI(self.recentlyPOI[indexPath.row])
        } else {
            selectedCallBack(pois[indexPath.row])
            LocationManager.addRecentlyPOI(pois[indexPath.row])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        superview?.endEditing(true)
    }
}
