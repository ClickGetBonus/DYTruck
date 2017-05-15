//
//  EstimateVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import EDStarRating


class EstimateVC: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starView: EDStarRating!
    @IBOutlet weak var textView: SPTextView!
    
    @IBOutlet weak var checkButton: UIButton!
    var isCheck: Bool = false
    
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
        starView.rating = 0
        starView.editable = true
        starView.horizontalMargin = 0
        starView.displayMode = 2
    }
    
    @IBAction func onCheck(_ sender: Any) {
        isCheck = !isCheck
        if isCheck {
            self.checkButton.setImage(UIImage(named: "01"), for: .normal)
        } else {
            self.checkButton.setImage(UIImage(named: "02"), for: .normal)
        }
    }
    
    
    @IBAction func onEstimate(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
