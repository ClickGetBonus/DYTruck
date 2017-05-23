//
//  AddressVC.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddressVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var addresss: [DYAddress] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getAddress()
        self.initSubviews()
    }
    
    func initSubviews() {
        
        self.setupBackItem()
        
        tableView.register(AddressCell.nib, forCellReuseIdentifier: AddressCell.className)
    }
    
    @IBAction func onAddAddress(_ sender: Any) {
        
        self.getCitys { (_) in
            
            let addressSelectVC = AddressSelectVC()
            addressSelectVC.searchCity = LocationManager.address.city
            self.navigationController?.addChildViewController(addressSelectVC)
            self.navigationController?.view.addSubview(addressSelectVC.view)
            addressSelectVC.view.frame = self.view.bounds
            addressSelectVC.view.transitionIn(UIOffset(horizontal: 0, vertical: self.view.height), complete: { })
            
            let dismissBehavior = { (vc: AddressSelectVC) in
                vc.view.transitionOut(UIOffset(horizontal: 0, vertical: self.view.height), complete: {
                    vc.view.removeFromSuperview()
                    vc.removeFromParentViewController()
                })
            }
            addressSelectVC.dismissBehavior = dismissBehavior
            
            addressSelectVC.selectCallBack = self.postAddress
        }
    }
    
    func getAddress() {
        let api = MyAddressApi(token: UserManager.authentication.token!)
        api.startWithCompletionBlock(success: { (request) in
            
            let response = MyAddressApi.Response.parse(data: request.responseString)!
            self.addresss = response.data!
            self.tableView.reloadData()
        }) { (request) in
            
        }
    }
    
    
    
    func postAddress( _ poi: MapPOI) {
        
        let addAddressApi = AddAddressApi(token: UserManager.authentication.token!,
                                          province: poi.province!,
                                          city: poi.city!,
                                          district: poi.district!,
                                          street: poi.address!,
                                          address: poi.name!,
                                          lat: poi.latitude!,
                                          lon: poi.longitude!)
        addAddressApi.startWithCompletionBlock(success: { (request) in
            
            SVProgressHUD.showSuccess(withStatus: "添加成功")
            SVProgressHUD.dismiss(withDelay: DYHudPresentationInterval)
            self.getAddress()
        }, failure: { (request) in
            
        })
    }
}


// MARK: - Network
extension AddressVC {
    func getCitys( _ complete: @escaping ([City]) -> Void ) {
        
        let citysApi = GetCitysApi(pattern: OrderPattern.special)
        citysApi.ignoreCache = true
        citysApi.startWithCompletionBlock(success: { (request) in
            
            let response: GetCitysResponse? = GetCitysApi.Response.parse(data: request.responseString)
            let citys: [City]? = response?.data
            DYManager.citys = citys ?? []
            
            complete(citys!)
        }) { (request) in
            
        }
    }
}


extension AddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.className) as! AddressCell
        let address = addresss[indexPath.row]
        cell.titleLabel.text = address.address
        cell.subTitleLabel.text = address.street
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}


