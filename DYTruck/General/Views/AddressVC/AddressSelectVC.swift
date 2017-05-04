//
//  AddressSelectVC.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class AddressSelectVC: UIViewController {
    
    enum SelectState {
        case address
        case city
    }
    var state: SelectState = .address {
        didSet {
            switch state {
            case .address:
                self.addressTableView.isHidden = false
                self.cityPickerView.isHidden = true
            case .city:
                self.addressTableView.isHidden = true
                self.cityPickerView.isHidden = false
            }
        }
    }
    
    var selectCallBack: (String) -> Void = { _ in } {
        didSet {
            self.addressTableView.selectedCallBack = {
                self.selectCallBack($0)
                self.dismissBehavior(self)
            }
        }
    }
    var dismissBehavior: (AddressSelectVC) -> Swift.Void = {
        $0.dismiss(animated: true, completion: nil)
    }
    
    
    let headerView: AddressHeaderView = AddressHeaderView()
    let addressTableView: AddressTableView = AddressTableView(frame: CGRect.zero, style: .plain)
    let cityPicker: TLCityPickerController = TLCityPickerController()
    var cityPickerView: UIView = UIView()
    var tableViewEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            self.updateSubviewsFrame()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.initSubviews()
    }
    
    func initSubviews() {
        
        self.headerView.cancelCallBack = {
            self.dismissBehavior(self)
        }
        self.headerView.selectCallBack = {
            if self.state == .city {
                self.state = .address
            } else {
                self.state = .city
            }
        }
        self.headerView.editCallBack = { key in
            
            self.state = .address
            self.addressTableView.setSearchKey(key)
        }
        self.view.addSubview(self.headerView)
        
        
        self.addressTableView.selectedCallBack = { _ in
            self.dismissBehavior(self)
        }
        self.view.addSubview(self.addressTableView)
        
        
        self.cityPickerView = self.cityPicker.view
        self.cityPicker.delegate = self
        self.cityPicker.hotCitys = ["100010000", "200010000", "300210000", "600010000", "300110000"]
        self.addChildViewController(self.cityPicker)
        self.view.addSubview(self.cityPickerView)
        
        self.cityPickerView.isHidden = true
        self.addressTableView.isHidden = false
        
        self.updateSubviewsFrame()
    }
    
    func updateSubviewsFrame() {
        
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 80)
        
        self.addressTableView.frame = CGRect(x: tableViewEdgeInsets.left,
                                             y: self.headerView.height + tableViewEdgeInsets.top,
                                             width: self.view.width - tableViewEdgeInsets.left - tableViewEdgeInsets.right,
                                             height: self.view.height - self.headerView.height - tableViewEdgeInsets.top - tableViewEdgeInsets.bottom)
        self.cityPickerView.frame = self.addressTableView.frame
    }
}

extension AddressSelectVC: TLCityPickerDelegate {
    
    func cityPickerController(_ cityPickerViewController: TLCityPickerController!, didSelect city: TLCity!) {
        self.headerView.cityLabel.text = city.cityName
        self.state = .address
    }
    
    func cityPickerControllerDidCancel(_ cityPickerViewController: TLCityPickerController!) {
        
    }
}
