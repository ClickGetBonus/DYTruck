//
//  ConfirmOrderVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/8.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class ConfirmOrderVC: UITableViewController {
    
    
    var payTimeSelection:Int = 0
    
    let imageViewTag = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
    }
    
    
    @IBAction func onConfirm(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SendOrderVC")
        self.navigationController?.show(vc, sender: nil)
    }
}

extension ConfirmOrderVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            if self.payTimeSelection != 0 {
                let imageView = tableView.cellForRow(at: IndexPath(row: self.payTimeSelection-1, section: 1))?.viewWithTag(imageViewTag) as! UIImageView
                imageView.image = UIImage(named: "02")
            }
            
            let imageView2 = tableView.cellForRow(at: indexPath)?.viewWithTag(imageViewTag) as! UIImageView
            imageView2.image = UIImage(named: "01")
            self.payTimeSelection = indexPath.row + 1
        }
    }
}
