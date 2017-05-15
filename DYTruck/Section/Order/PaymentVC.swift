//
//  PaymentVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import EDStarRating

class PaymentVC: UITableViewController {
    
    @IBOutlet weak var payWechatButton: UIButton!
    @IBOutlet weak var payAliButton: UIButton!
    @IBOutlet weak var payCashButton: UIButton!
    @IBOutlet weak var cashTitleLabel: UILabel!
    @IBOutlet weak var cashAccountLabel: UILabel!
    var paymentSelection = 0
    
    @IBOutlet weak var starView: EDStarRating!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        self.setupBackItem(target: self, selector: #selector(goMain))
    }
    
    func goMain() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    func initSubviews() {
        
        starView.starImage = UIImage(named: "grzx_dj_02")
        starView.starHighlightedImage = UIImage(named: "grzx_dj_01")
        starView.maxRating = 5
        starView.rating = 4
        starView.editable = true
        starView.horizontalMargin = 0
        starView.displayMode = 2
        
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
    
    
    @IBAction func onPay(_ sender: Any) {
        self.performSegue(withIdentifier: "goEstimate", sender: nil)
    }
}
