//
//  SpecConfirmOrderVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class SpecConfirmOrderVC: UITableViewController {
    
    @IBOutlet weak var payWechatButton: UIButton!
    @IBOutlet weak var payAliButton: UIButton!
    @IBOutlet weak var payCashButton: UIButton!
    
    @IBOutlet weak var cashTitleLabel: UILabel!
    @IBOutlet weak var cashAccountLabel: UILabel!
    
    var paymentSelection = 0
    
    var payTimeSelection:Int = 0
    
    let imageViewTag = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        
        payWechatButton.layer.borderWidth = 1.0
        payWechatButton.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        
        payAliButton.layer.borderWidth = 1.0
        payAliButton.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        
        payCashButton.layer.borderWidth = 1.0
        payCashButton.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
    }
    
    
    @IBAction func onPayButton(_ sender: UIButton) {
        
        
        payWechatButton.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        payAliButton.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        payCashButton.layer.borderColor = kRGBColorFromHex(0xdddddd).cgColor
        
        switch sender.tag {
        case 1:
            payWechatButton.layer.borderColor = kRGBColorFromHex(0xf6a224).cgColor
            self.paymentSelection = 1
        case 2:
            self.payAliButton.layer.borderColor = kRGBColorFromHex(0xf6a224).cgColor
            self.paymentSelection = 2
        default:
            self.payCashButton.layer.borderColor = kRGBColorFromHex(0xf6a224).cgColor
            self.paymentSelection = 3
        }
    }
    

    @IBAction func onConfirm(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SendOrderVC")
        self.navigationController?.show(vc, sender: nil)
    }
}

extension SpecConfirmOrderVC {
    
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
