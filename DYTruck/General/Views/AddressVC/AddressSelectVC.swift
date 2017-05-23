//
//  AddressSelectVC.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    let headerView: AddressHeaderView = AddressHeaderView()
    let addressTableView: AddressTableView = AddressTableView(frame: CGRect.zero, style: .plain)
    
    let searchApi: AMapSearchAPI = AMapSearchAPI()
    var searchCity: String? = LocationManager.address.city {
        didSet {
            self.headerView.cityLabel.text = searchCity
        }
    }
    let cityPicker: TLCityPickerController = TLCityPickerController()
    var cityPickerView: UIView = UIView()
    var keywords: String = ""
    
    var selectCallBack: (MapPOI) -> Void = { _ in } {
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
        
        
        searchApi.delegate = self
        
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
            self.keywords = key ?? ""
            if !self.keywords.isEmpty {
                self.searchPOI()
            }
            
            self.addressTableView.showRecently = self.keywords.isEmpty
            
        }
        self.view.addSubview(self.headerView)
        
        
        self.addressTableView.selectedCallBack = { _ in
            self.dismissBehavior(self)
        }
        self.view.addSubview(self.addressTableView)
        
        
        
        self.cityPicker.delegate = self
        let array = City.changeToTLCity(DYManager.citys)
        self.cityPicker.citys = array as! NSMutableArray
        let locationCityName = LocationManager.address.city ?? array.first?.cityName
        var locationCity = array.first!
        for city in array {
            if city.cityName == locationCityName {
                locationCity = city
            }
        }
        self.cityPicker.locationCity = locationCity
        
        self.cityPickerView = self.cityPicker.view
        self.addChildViewController(self.cityPicker)
        self.view.addSubview(self.cityPickerView)
        
        self.cityPickerView.isHidden = true
        
        self.headerView.addShadow()
        
        self.updateSubviewsFrame()
    }
    
    func updateSubviewsFrame() {
        
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 80)
        
        self.addressTableView.frame = CGRect(x: tableViewEdgeInsets.left,
                                             y: self.headerView.height + tableViewEdgeInsets.top,
                                             width: self.view.width - tableViewEdgeInsets.left - tableViewEdgeInsets.right,
                                             height: self.view.height - self.headerView.height - tableViewEdgeInsets.top - tableViewEdgeInsets.bottom)
        self.cityPickerView.frame = CGRect(x: tableViewEdgeInsets.left,
                                           y: self.headerView.height + tableViewEdgeInsets.top,
                                           width: self.view.width - tableViewEdgeInsets.left - tableViewEdgeInsets.right,
                                           height: self.view.height - self.headerView.height - tableViewEdgeInsets.top - tableViewEdgeInsets.bottom)
        self.cityPicker.updateSubviewsFrame()
    }
}

extension AddressSelectVC: TLCityPickerDelegate {
    
    func cityPickerController(_ cityPickerViewController: TLCityPickerController!, didSelect city: TLCity!) {
        self.headerView.cityLabel.text = city.cityName
        self.searchCity = city.cityName
        self.state = .address
    }
    
    func cityPickerControllerDidCancel(_ cityPickerViewController: TLCityPickerController!) {
        
    }
}

//MARK: - AMapSearch
extension AddressSelectVC: AMapSearchDelegate {
    
    func searchPOI() {
        let request = AMapPOIKeywordsSearchRequest()
        request.keywords = self.keywords
        request.requireExtension = true
        request.city = self.searchCity
        
        request.cityLimit = true
        request.requireSubPOIs = true
        
        self.searchApi.aMapPOIKeywordsSearch(request)
    }
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        SVProgressHUD.showError(withStatus: "获取定位信息失败")
        SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        let pois: [AMapPOI] = response.pois
        var localPois: [MapPOI] = []
        for poi in pois {
            localPois.append(MapPOI(poi))
        }
        self.addressTableView.pois = localPois
    }
}
