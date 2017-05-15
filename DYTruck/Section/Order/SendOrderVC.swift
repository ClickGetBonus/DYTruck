//
//  SendOrderVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/11.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class SendOrderVC: UIViewController {
    
    @IBOutlet weak var mapView: MAMapView!
    
    var informationView: MainInfoView = MainInfoView()
    var infoViewHidden: Bool = true
    var countDown:Int = 0
    var timer: Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        self.perform(#selector(goWaitArrive), with: nil, afterDelay: 3.0)
        self.setupBackItem(target: self, selector: #selector(goMain))
    }
    
    func initSubviews() {
        
        mapView.delegate = self
        mapView.showsUserLocation = true;
        mapView.userTrackingMode = .follow;
    }
    
    func goMain() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func goWaitArrive() {
        self.performSegue(withIdentifier: "goWaitArrive", sender: nil)
    }
}


// MARK: - Information View
extension SendOrderVC {

    func addNewInfo() {
        
        if self.infoViewHidden {
            self.showInfoView()
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(hideInfoViewIfNeed), userInfo: nil, repeats: true)
            timer.fire()
        }
        
        informationView.addInformation(getAttributedString("123"))
    }
    
    func hideInfoViewIfNeed() {
        
        countDown -= 1
        if countDown <= 0 {
            self.hideInfoView()
            timer.invalidate()
        }
    }
    
    
    func showInfoView() {
        if self.infoViewHidden {
            informationView.transitionIn(UIOffset(horizontal: 0, vertical: -50)) {
                self.infoViewHidden = false
            }
        }
    }
    
    func hideInfoView() {
        if !self.infoViewHidden {
            informationView.transitionOut(UIOffset(horizontal: 0, vertical: -50)) {
                self.infoViewHidden = true
            }
        }
    }
    
    func getAttributedString(_ num: String) -> NSAttributedString {
        let info: NSMutableAttributedString = NSMutableAttributedString(string: "已为您通知到\(num)名司机 等待 00:30")
        info.addAttribute(NSForegroundColorAttributeName, value: kRGBColorFromHex(0xf6a224), range: NSMakeRange(6, num.characters.count))
        
        info.addAttribute(NSForegroundColorAttributeName, value: kRGBColorFromHex(0xf6a224), range: NSMakeRange(12+num.characters.count, 5))
        return info
    }
}


// MARK: - MapView Delegate
extension SendOrderVC: MAMapViewDelegate {
    func mapViewRegionChanged(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        
    }
}


