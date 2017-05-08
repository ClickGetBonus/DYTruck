//
//  MainVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleIndicator: UIImageView!
    
    let userMenuWidth: CGFloat = 270
    
    
    @IBOutlet weak var patternSelectView: PatternSelectView!
    
    
    @IBOutlet weak var mapView: MAMapView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewTopConstrant: NSLayoutConstraint!
    
    var bottomView: MainBottomView = MainBottomView(.specialCar)
    
    var patternSelectIndex: Int = 0
    var selectedPattern: Pattern = .specialCar
    
    var informationView: MainInfoView = MainInfoView()
    var infoViewHidden: Bool = true
    var isInAnimated: Bool = false
    var veilView = UIView()
    
    var isHiddenStatusBar: Bool = false {
        didSet {
            self.updateStatusBar()
        }
    }
    var firstPointPositionX: CGFloat = 0
    var shouldHideLeftMenu: Bool = false
    var panRecognizer = UIPanGestureRecognizer()
    
    var countDown:Int = 0
    var timer: Timer = Timer()
    
    var userMenu: MainUserView = MainUserView()
    var catchView: CatchTouchView = CatchTouchView()
    
    
    var cityVC: TLCityPickerController = TLCityPickerController()
    var cityView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBarBgAlpha = 0
        
        
        initSubviews()
        
        
    }
    
    
    func initSubviews() {
        
        
        AMapServices.shared().enableHTTPS = true
        mapView.delegate = self
        mapView.showsUserLocation = true;
        mapView.userTrackingMode = .follow;
        //        mapView.zoomLevel = 17
        //        mapView.centerCoordinate = mapView.userLocation.coordinate
        
        
        self.bottomView.frame = self.mapView.frame
        self.configure(self.bottomView)
        
        self.patternSelectView.selectCallBack = self.patternViewDidSelect
        self.patternSelectView.patterns = [Pattern.specialCar, Pattern.shareingCar, Pattern.espressage, Pattern.longJourney, Pattern.storage]
        
        informationView = MainInfoView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.currentBounds().width-30, height: 34))
        informationView.isHidden = true
        self.view.insertSubview(informationView, belowSubview: topView)
        
        self.view.insertSubview(bottomView, belowSubview: informationView)
        
        self.perform(#selector(addNewInfo), with: nil, afterDelay: 3)
        
        
        self.userMenu = MainUserView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: userMenuWidth,
                                                   height: self.view.height))
        self.userMenu.backgroundColor = UIColor.white
        self.userMenu.isHidden = true
        self.userMenu.avatarCallBack = self.onClickAvatar
        self.userMenu.orderCallBack = self.onClickOrder
        self.userMenu.walletCallBack = self.onClickWallet
        self.userMenu.serviceCallBack = self.onClickService
        self.userMenu.settingCallBack = self.onClickSetting
        self.view.insertSubview(self.userMenu, aboveSubview: self.topView)
    }
    override func viewDidLayoutSubviews() {
        
        self.patternSelectView.itemWidthConstraint.constant = self.view.width/5
        self.informationView.origin = CGPoint(x: 15, y: self.topView.bottom + 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.userMenu.isHidden {
            self.isHiddenStatusBar = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func onClickUserItem(_ sender: Any) {
        
        veilView = UIView(frame: self.view.frame)
        let tapRes = UITapGestureRecognizer(target: self, action: #selector(hideUserMenu))
        veilView.addGestureRecognizer(tapRes)
        veilView.backgroundColor = UIColor.black
        veilView.alpha = 0
        self.view.insertSubview(veilView, belowSubview: self.userMenu)
        
        UIView.animate(withDuration: 0.5) {
            self.veilView.alpha = 0.6
        }
        
        self.isHiddenStatusBar = true
        
        popUserMenu()
    }
    
    @IBAction func onSelectCity(_ sender: Any) {
        showCityPicker()
    }
}

// MARK: - TLCityPicker
extension MainVC: TLCityPickerDelegate {
    
    func showCityPicker() {
        self.titleIndicator.rotation(by: Double(M_PI))
        
        self.cityVC = TLCityPickerController()
        self.cityVC.delegate = self
        self.cityVC.hotCitys = ["100010000", "200010000", "300210000", "600010000", "300110000"]
        
        self.cityView = self.cityVC.view
        let padding: CGFloat = 20
        self.cityView.frame = CGRect(x:padding ,
                                     y: self.topView.bottom+padding,
                                     width: self.mapView.width-2*padding,
                                     height: self.mapView.height-padding)
        self.addChildViewController(self.cityVC)
        self.view.addSubview(self.cityView)
        
        self.catchView = CatchTouchView(frame: self.view.bounds, respondView: self.cityView) { (view) in
            self.hideCityPicker()
            view?.removeFromSuperview()
        }
        self.view.addSubview(self.catchView)
        self.cityView.transitionIn(UIOffset(horizontal: 0, vertical: self.mapView.height), complete: {
            
        })
    }
    
    func hideCityPicker() {
        self.titleIndicator.rotation(by: Double(-M_PI))
        
        self.cityView.transitionOut(UIOffset(horizontal: 0, vertical: self.mapView.height), complete: {
            self.cityVC.delegate = nil
            self.cityView.removeFromSuperview()
            self.cityVC.removeFromParentViewController()
            self.catchView.removeFromSuperview()
        })
        
    }
    
    func cityPickerControllerDidCancel(_ cityPickerViewController: TLCityPickerController!) {
        
    }
    
    func cityPickerController(_ cityPickerViewController: TLCityPickerController!, didSelect city: TLCity!) {
        self.titleLabel.text = city.cityName
        self.hideCityPicker()
    }
}

// MARK: - Left Menu
extension MainVC {
    
    func popUserMenu() {
        self.userMenu.frame = CGRect(x: 0,
                                     y: 0,
                                     width: userMenuWidth,
                                     height: self.view.height)
        self.userMenu.isHidden = false
        userMenu.transitionIn(UIOffset(horizontal: -userMenuWidth, vertical: 0)) {
            
        }
        
        panRecognizer = UIPanGestureRecognizer(target: self,
                                               action: #selector(handlePanRecognizer(_:)))
        self.view.addGestureRecognizer(panRecognizer)
    }
    
    func handlePanRecognizer( _ panRecognizer: UIPanGestureRecognizer) {
        
        guard panRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) else {
            return
        }
        
        let currentTouchPoint = panRecognizer.location(in: self.view)
        let currentTouchX = currentTouchPoint.x
        
        let velocityX: CGFloat = panRecognizer.velocity(in: self.view).x
        if panRecognizer.state == .began {
            self.firstPointPositionX = currentTouchX
        } else if panRecognizer.state == .changed {
            
            let moveX = currentTouchX - self.firstPointPositionX
            self.firstPointPositionX = currentTouchX
            
            let originX: CGFloat = min(0, self.userMenu.left + moveX)
            
            if (originX <= -0.5 * self.userMenuWidth && velocityX < 0) || velocityX <= -100 {
                
                self.shouldHideLeftMenu = true
            }
            
            if (originX > -0.5 * self.userMenuWidth && velocityX > 0) || velocityX > 100 {
                
                self.shouldHideLeftMenu = false
            }
            
            self.userMenu.left = originX
        } else if panRecognizer.state == .ended || panRecognizer.state == .cancelled {
            
            if self.shouldHideLeftMenu {
                self.hideUserMenu()
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.userMenu.left = 0
                })
            }
        }
        
    }
    
    
    func hideUserMenu() {
        self.isHiddenStatusBar = false
        
        self.view.removeGestureRecognizer(panRecognizer)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.veilView.alpha = 0
            self.userMenu.left = -self.userMenu.width
        }) { _ in
            self.veilView.removeFromSuperview()
            self.userMenu.isHidden = true
        }
    }
    
    func onClickAvatar() {
        
    }
    
    func onClickIntegral() {
        
    }
    
    func onClickFollow() {
        
    }
    
    
    func onClickOrder() {
        
        self.isHiddenStatusBar = false
        
        self.performSegue(withIdentifier: "goOrder", sender: nil)
    }
    
    func onClickWallet() {
        self.isHiddenStatusBar = false
        
        self.performSegue(withIdentifier: "goWallet", sender: nil)
    }
    
    func onClickService() {
        
    }
    
    func onClickSetting() {
        
        self.isHiddenStatusBar = false
        
        self.performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHiddenStatusBar
    }
    
    func updateStatusBar() {
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

// MARK: - Nav View
extension MainVC {
    
    
}

// MARK: - Pattern View
extension MainVC {
    
    
    
    func patternViewDidSelect( _ index: Int) {
        
        updateBottomView(index)
    }
    
}



// MARK: - Information View
extension MainVC {
    
    
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
        let info: NSMutableAttributedString = NSMutableAttributedString(string: "附近有\(num)辆货车可提供服务")
        info.addAttribute(NSForegroundColorAttributeName, value: kRGBColorFromHex(0xf6a224), range: NSMakeRange(3, num.characters.count))
        return info
    }
}


// MARK: - Bottom View
extension MainVC {
    
    func configure(_ bottomView: MainBottomView) {
        bottomView.locationBehavior = {
            print("更新定位!!!")
        }
        
        bottomView.requestSelectAddressBehavior = self.selectAddress
        
        bottomView.completeEditBehavior = { bottomView in
            print("地址输入完毕!! 出发点: \(bottomView.departureArray) \n 目的地: \(bottomView.destination)")
            let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SpecialOrderVC") as! SpecialOrderVC
            vc.configure(bottomView.departureTimeString, location: bottomView.departureArray, destination: bottomView.destination)
            self.navigationController?.present(UINavigationController(rootViewController: vc),
                                               animated: true, completion: nil)
        }
    }
    
    func selectAddress(for index: Int) {
        self.bottomView.transitionOut(UIOffset(horizontal: 0, vertical: self.bottomView.height),
                                      complete: {})
        self.topView.transitionOut(UIOffset(horizontal: 0, vertical: -self.topView.height),
                                   complete: {})
        
        self.topViewTopConstrant.constant = -self.topView.height
        UIView.animate(withDuration: 0.3, animations: {
            self.topView.layoutSubviews()
        }, completion: nil)
        
        
        let addressSelectVC = AddressSelectVC()
        
        self.addChildViewController(addressSelectVC)
        self.view.addSubview(addressSelectVC.view)
        addressSelectVC.view.frame = self.view.bounds
        
        addressSelectVC.view.transitionIn(UIOffset(horizontal: 0, vertical: self.view.height), complete: { })
        addressSelectVC.tableViewEdgeInsets = UIEdgeInsets(top: 10,
                                                           left: 10,
                                                           bottom: 10,
                                                           right: 10)
        addressSelectVC.selectCallBack = { address in
            self.bottomView.setAddress(address, in: index)
        }
        
        addressSelectVC.dismissBehavior = { vc in
            vc.view.transitionOut(UIOffset(horizontal: 0, vertical: self.view.height), complete: {
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
            })
            
            self.bottomView.transitionOut(UIOffset(horizontal: 0, vertical: -self.bottomView.height),
                                          complete: {})
            self.topView.transitionOut(UIOffset(horizontal: 0, vertical: self.topView.height),
                                       complete: {})
            self.topViewTopConstrant.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.topView.layoutSubviews()
            }, completion: nil)
            
        }
    }
    
    func updateBottomView(_ index: Int) {
        
        guard index != self.patternSelectIndex else {
            return
        }
        
        let patterns = [Pattern.specialCar, Pattern.shareingCar, Pattern.espressage, Pattern.longJourney, Pattern.storage]
        let newBottomView = MainBottomView(patterns[index])
        newBottomView.frame = self.bottomView.frame
        self.configure(newBottomView)
        self.view.insertSubview(newBottomView, aboveSubview: self.mapView)
        
        var oldViewOffsetH: CGFloat
        var newViewOffsetH: CGFloat
        
        
        if index > self.patternSelectIndex {
            oldViewOffsetH = -self.view.width
            newViewOffsetH = self.view.width
        } else {
            oldViewOffsetH = self.view.width
            newViewOffsetH = -self.view.width
        }
        
        self.patternSelectView.isUserInteractionEnabled = false
        self.bottomView.transitionOut(UIOffset(horizontal: oldViewOffsetH, vertical: 0)) {
            self.bottomView.frame = self.mapView.frame
        }
        
        newBottomView.transitionIn(UIOffset(horizontal: newViewOffsetH, vertical: 0)) {
            self.bottomView.removeFromSuperview()
            self.bottomView = newBottomView
            self.patternSelectIndex = index
            self.selectedPattern = patterns[index]
            self.patternSelectView.isUserInteractionEnabled = true
        }
    }
    
    
}





// MARK: - MapView Delegate
extension MainVC: MAMapViewDelegate {
    func mapViewRegionChanged(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        
    }
}





