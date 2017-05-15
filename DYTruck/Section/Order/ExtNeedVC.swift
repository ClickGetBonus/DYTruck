//
//  ExtNeedVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/8.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class ExtNeedVC: UITableViewController {
    
    var selections: [Bool] = [false, false, false, false, false]
    var completeBehavior: ([Bool]) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let imageView = cell?.contentView.viewWithTag(11) as! UIImageView
        imageView.image = UIImage(named: selections[indexPath.row] ? "ty_wxy_icn" : "ty_xz_icn")
        selections[indexPath.row] = !selections[indexPath.row]
    }
    
    
    
    @IBAction func onConfirm(_ sender: Any) {
        self.completeBehavior(self.selections)
        self.navigationController?.popViewController(animated: true)
    }
    
}
