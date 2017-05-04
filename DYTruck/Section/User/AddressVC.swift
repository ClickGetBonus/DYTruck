//
//  AddressVC.swift
//  DYTruck
//
//  Created by Lan on 17/5/2.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class AddressVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
    }
    
    func initSubviews() {
        
        self.setupBackItem()
        
        tableView.register(AddressCell.nib, forCellReuseIdentifier: AddressCell.className)
    }
    
    @IBAction func onAddAddress(_ sender: Any) {
        let addressSelectVC = AddressSelectVC()
        
        self.navigationController?.addChildViewController(addressSelectVC)
        self.navigationController?.view.addSubview(addressSelectVC.view)
        addressSelectVC.view.frame = self.view.bounds
        addressSelectVC.view.transitionIn(UIOffset(horizontal: 0, vertical: self.view.height), complete: { })
        addressSelectVC.dismissBehavior = { vc in
            vc.view.transitionOut(UIOffset(horizontal: 0, vertical: self.view.height), complete: {
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
            })
        }
    }
    
}

extension AddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.className) as! AddressCell
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


