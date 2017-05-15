//
//  WaitArriveVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/12.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit
import EDStarRating

class WaitArriveVC: UIViewController {
    
    @IBOutlet weak var mapView: MAMapView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var plateNumLabel: UILabel!
    @IBOutlet weak var truckModelLabel: UILabel!
    @IBOutlet weak var truckTypeLabel: UILabel!
    @IBOutlet weak var starView: EDStarRating!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBAction func onMessage(_ sender: Any) {
        
    }
    
    @IBAction func onVoice(_ sender: Any) {
        
    }
    @IBAction func onTelephone(_ sender: Any) {
        
    }
    
    @IBAction func goOrderInfo(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        self.perform(#selector(goWaitLoading), with: nil, afterDelay: 3.0)
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
    }
    
    func goMain() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func goWaitLoading() {
        self.performSegue(withIdentifier: "goWaitLoading", sender: nil)
    }

}


// MARK: - MapView Delegate
extension WaitArriveVC: MAMapViewDelegate {
    func mapViewRegionChanged(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        
    }
}


