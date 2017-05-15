//
//  WaitLoadingVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import EDStarRating


class WaitLoadingVC: UIViewController {
    
    @IBOutlet weak var mapView: MAMapView!

    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var plateNumLabel: UILabel!
    @IBOutlet weak var truckModelLabel: UILabel!
    @IBOutlet weak var truckTypeLabel: UILabel!
    @IBOutlet weak var starView: EDStarRating!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var timerLabel: MZTimerLabel!
    
    @IBAction func onMessage(_ sender: Any) {
        
    }
    
    @IBAction func onVoice(_ sender: Any) {
        
    }
    @IBAction func onTelephone(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.initSubviews()
        
        self.perform(#selector(goPayment), with: nil, afterDelay: 3.0)
        self.setupBackItem(target: self, selector: #selector(goMain))
    }
    
    func initSubviews() {
        
        mapView.delegate = self
        mapView.showsUserLocation = true;
        mapView.userTrackingMode = .follow;
        
        starView.starImage = UIImage(named: "grzx_dj_02")
        starView.starHighlightedImage = UIImage(named: "grzx_dj_01")
        starView.maxRating = 5
        starView.rating = 4
        starView.editable = false
        starView.horizontalMargin = 0
        starView.displayMode = 2
        
        
        self.timerLabel.timerType = .init(1)
        self.timerLabel.setCountDownTime(30*60)
        self.timerLabel.timeFormat = "HH:mm:ss"
        self.timerLabel.start()
    }
    
    func goPayment() {
        self.performSegue(withIdentifier: "goPayment", sender: nil)
    }
    
    func goMain() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}


// MARK: - MapView Delegate
extension WaitLoadingVC: MAMapViewDelegate {
    func mapViewRegionChanged(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        
    }
}


