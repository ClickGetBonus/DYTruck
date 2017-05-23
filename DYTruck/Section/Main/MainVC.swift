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
    var firstUpdateLocation: Bool = true
    
    var locationCity: String = "" {
        didSet {
            self.titleLabel.text = locationCity
        }
    }
    
    @IBOutlet weak var patternSelectView: PatternSelectView!
    
    @IBOutlet weak var mapView: MAMapView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewTopConstrant: NSLayoutConstraint!
    
    var bottomView: MainBottomView = MainBottomView(.special)
    
    var patternSelectIndex: Int = 0
    var selectedPattern: Pattern = .special
    
    var informationView: MainInfoView = MainInfoView()
    var infoViewHidden: Bool = true
    var isInAnimated: Bool = false
    
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
    
    var departures: [MapPOI] = []
    var destination: MapPOI? = nil
    
    let searchApi: AMapSearchAPI = AMapSearchAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBarBgAlpha = 0
        
        
        initSubviews()
    }
    
    
    func initSubviews() {
        
        searchApi.delegate = self
        AMapServices.shared().enableHTTPS = true
        mapView.delegate = self
        mapView.showsUserLocation = true;
        mapView.userTrackingMode = .follow;
        //        mapView.zoomLevel = 17
        //        mapView.centerCoordinate = mapView.userLocation.coordinate
        
        
        self.bottomView.frame = self.mapView.frame
        self.configure(self.bottomView)
        
        self.topView.addShadow()
        
        self.patternSelectView.selectCallBack = self.patternViewDidSelect
        self.patternSelectView.patterns = [Pattern.special, Pattern.shared, Pattern.expressage, Pattern.longJourney, Pattern.storage]
        
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
        
        self.isHiddenStatusBar = !self.userMenu.isHidden
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func hideMainItems() {
        
        self.bottomView.frame = self.mapView.frame
        self.bottomView.transitionOut(UIOffset(horizontal: 0, vertical: self.bottomView.height),
                                      complete: {})
        self.topView.transitionOut(UIOffset(horizontal: 0, vertical: -self.topView.height),
                                   complete: {})
        
        self.topViewTopConstrant.constant = -self.topView.height
        UIView.animate(withDuration: 0.3, animations: {
            self.topView.layoutSubviews()
        }, completion: nil)
    }
    
    func showMainItems() {
        
        self.bottomView.frame = self.mapView.frame
        self.bottomView.transitionIn(UIOffset(horizontal: 0, vertical: self.bottomView.height),
                                     complete: {})
        self.topView.transitionOut(UIOffset(horizontal: 0, vertical: self.topView.height),
                                   complete: {})
        self.topViewTopConstrant.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.topView.layoutSubviews()
        }, completion: nil)
    }
    
    
    @IBAction func onClickUserItem(_ sender: Any) {
        
        guard UserManager.isLogin else {
            self.navigationController?.present(R.storyboard.login().instantiateInitialViewController()!, animated: true, completion: nil)
            return
        }
        
        self.view.addVeilViewBelow(self.userMenu, target:self, selector: #selector(hideUserMenu))
        
        self.isHiddenStatusBar = true
        
        popUserMenu()
    }
    
    @IBAction func onSelectCity(_ sender: Any) {
        
        self.getCitys { (citys) in
            self.showCityPicker(citys)
        }
    }
    
    @IBAction func onClickMessage(_ sender: Any) {
        guard UserManager.isLogin else {
            self.navigationController?.present(R.storyboard.login.instantiateInitialViewController()!, animated: true, completion: nil)
            return
        }
        
        self.performSegue(withIdentifier: "goMessage", sender: nil)
    }
}


// MARK: - TLCityPicker
extension MainVC: TLCityPickerDelegate {
    
    func showCityPicker( _ cityData: [City]) {
        self.titleIndicator.rotation(by: Double.pi)
        
        self.cityVC = TLCityPickerController()
        self.cityVC.delegate = self
        let array = City.changeToTLCity(cityData)
        self.cityVC.citys = array as! NSMutableArray
        let locationCityName = LocationManager.address.city ?? array.first?.cityName
        var locationCity = array.first!
        for city in array {
            if city.cityName == locationCityName {
                locationCity = city
            }
        }
        self.cityVC.locationCity = locationCity
        
        self.cityView = self.cityVC.view
        self.cityView.frame = CGRect(x: 16,
                                     y: 40,
                                     width: self.mapView.width - 32,
                                     height: self.mapView.height - 40)
        self.addChildViewController(self.cityVC)
        self.view.addSubview(self.cityView)
        self.cityVC.updateSubviewsFrame()
        
        self.cityView.transitionIn(UIOffset(horizontal: 0, vertical: self.mapView.height), complete:nil)
        
        self.hideMainItems()
    }
        
    func hideCityPicker() {
        self.titleIndicator.rotation(by: -Double.pi)
        
        self.cityView.transitionOut(UIOffset(horizontal: 0, vertical: self.mapView.height), complete: {
            self.cityVC.delegate = nil
            self.cityView.removeFromSuperview()
            self.cityVC.removeFromParentViewController()
            self.catchView.removeFromSuperview()
        })
        
        self.showMainItems()
    }
    
    func cityPickerControllerDidCancel(_ cityPickerViewController: TLCityPickerController!) {
        self.hideCityPicker()
    }
    
    func cityPickerController(_ cityPickerViewController: TLCityPickerController!, didSelect city: TLCity!) {
        self.titleLabel.text = city.cityName
        self.hideCityPicker()
    }
}

// MARK: - Network
extension MainVC {
    func getCitys( _ complete: @escaping ([City]) -> Void ) {
        
        let citysApi = GetCitysApi(pattern: self.selectedPattern.toOrderPattern())
        citysApi.ignoreCache = true
        citysApi.startWithCompletionBlock(success: { (request) in
            
            let response: GetCitysResponse? = GetCitysApi.Response.parse(data: request.responseString)
            let citys: [City]? = response?.data
            DYManager.citys = citys ?? []
            
            complete(citys!)
        }) { (request) in
            
        }
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
                self.hideUserMenu(true)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.userMenu.left = 0
                })
            }
        }
        
    }
    
    
    func hideUserMenu( _ anim: Bool) {
        self.isHiddenStatusBar = false
        
        self.view.hideVeilView((anim ? 0.5 : 0))
        
        self.view.removeGestureRecognizer(panRecognizer)
        
        UIView.animate(withDuration: (anim ? 0.5 : 0), animations: {
            self.userMenu.left = -self.userMenu.width
        }) { _ in
            self.userMenu.isHidden = true
        }
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
    
    func onClickAvatar() {
        
        self.isHiddenStatusBar = false
        self.performSegue(withIdentifier: "goUserInfo", sender: nil)
        self.hideUserMenu(false)
    }
    
    func onClickIntegral() {
        
    }
    
    func onClickFollow() {
        
    }
    
    
    func onClickOrder() {
        
        self.isHiddenStatusBar = false
        self.performSegue(withIdentifier: "goOrder", sender: nil)
        self.hideUserMenu(false)
    }
    
    func onClickWallet() {
        
        self.isHiddenStatusBar = false
        self.performSegue(withIdentifier: "goWallet", sender: nil)
        self.hideUserMenu(false)
    }
    
    func onClickService() {
        
    }
    
    func onClickSetting() {
        
        self.isHiddenStatusBar = false
        self.performSegue(withIdentifier: "goSetting", sender: nil)
        self.hideUserMenu(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSetting" {
            let vc = segue.destination as! SettingVC
            vc.logoutBehavior = {
                self.hideUserMenu(false)
                
            }
        }
    }
    
}


// MARK: - Nav View
extension MainVC {
    
    
}

// MARK: - Pattern View
extension MainVC {
    
    func patternViewDidSelect( _ index: Int) {
        if index < 3 {
            /*
            let getAutoApi = GetNearAutoApi(city: LocationManager.address.city!,
                                            range: 10000,
                                            lat: LocationManager.location.latitude,
                                            lon: LocationManager.location.longitude,
                                            type: OrderPattern(index))
            getAutoApi.startWithCompletionBlock(success: { (request) in
                
                let response = GetNearAutoApi.Response.parse(data: request.responseString!)!
                let autos: [NearAuto] = response.data!
                DLog(autos)
            }, failure: { (request) in
                
            })
             */
        }
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
            print("地址输入完毕!! 出发点: \(bottomView.departureArray.map{$0!.name}) \n 目的地: \(bottomView.destination?.name ?? "")")
            
            guard UserManager.isLogin else {
                let loginVC = R.storyboard.login().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let nav = UINavigationController(rootViewController: loginVC)
                loginVC.loginCompleteBehavior = {
                    self.goOrder(pattern: self.selectedPattern, bottomView: bottomView)
                }
                self.navigationController?.present(nav, animated: true, completion: nil)
                return
            }
            
            self.goOrder(pattern: self.selectedPattern, bottomView: bottomView)
        }
    }
    
    func goOrder(pattern: Pattern, bottomView: MainBottomView) {
        
        switch pattern {
        case .special:
            let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SpecialOrderVC") as! SpecialOrderVC
            vc.configure(bottomView.departureTimeString, location: bottomView.departureArray as! [MapPOI], destination: bottomView.destination!)
            self.navigationController?.present(UINavigationController(rootViewController: vc),
                                               animated: true, completion: nil)
        case .shared:
            let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SharedOrderVC") as! SharedOrderVC
            vc.configure(bottomView.departureTimeString, location: bottomView.departureArray as! [MapPOI], destination: bottomView.destination!)
            self.navigationController?.present(UINavigationController(rootViewController: vc),
                                               animated: true, completion: nil)
        case .expressage:
            let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "ExpressageOrderVC") as! ExpressageOrderVC
            vc.configure(bottomView.departureTimeString, location: bottomView.departureArray as! [MapPOI], destination: bottomView.destination!)
            self.navigationController?.present(UINavigationController(rootViewController: vc),
                                               animated: true, completion: nil)
        case .longJourney:
            let vc = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "LongJourneyOrderVC") as! LongJourneyOrderVC
            vc.configure(bottomView.departureTimeString, location: bottomView.departureArray as! [MapPOI], destination: bottomView.destination!)
            self.navigationController?.present(UINavigationController(rootViewController: vc),
                                               animated: true, completion: nil)
        default:
            break;
        }
        
        bottomView.deleteAllSelection()
    }
    
    func selectAddress(for index: Int) {
        self.hideMainItems()
        
        let addressSelectVC = AddressSelectVC()
        addressSelectVC.searchCity = self.locationCity
        self.addChildViewController(addressSelectVC)
        self.view.addSubview(addressSelectVC.view)
        addressSelectVC.view.frame = self.view.bounds
        
        addressSelectVC.view.transitionIn(UIOffset(horizontal: 0, vertical: self.view.height), complete: { })
        addressSelectVC.tableViewEdgeInsets = UIEdgeInsets(top: 10,
                                                           left: 10,
                                                           bottom: 10,
                                                           right: 10)
        addressSelectVC.selectCallBack = { poi in
            
            self.bottomView.setAddress(poi, in: index)
        }
        
        addressSelectVC.dismissBehavior = { vc in
            vc.view.transitionOut(UIOffset(horizontal: 0, vertical: self.view.height), complete: {
                vc.view.removeFromSuperview()
                vc.removeFromParentViewController()
            })
            
            self.showMainItems()
        }
    }
    
    func updateBottomView(_ index: Int) {
        
        guard index != self.patternSelectIndex else {
            return
        }
        
        let patterns = [Pattern.special, Pattern.shared, Pattern.expressage, Pattern.longJourney, Pattern.storage]
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





// MARK: - MapView
extension MainVC: MAMapViewDelegate {
    
    
    
    func mapViewRegionChanged(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        if firstUpdateLocation {
            firstUpdateLocation = false
            let coordinate = userLocation.location.coordinate
            LocationManager.location = coordinate
            let request = AMapReGeocodeSearchRequest()
            request.location = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.latitude),
                                                     longitude: CGFloat(coordinate.longitude))
            request.requireExtension = true
            self.searchApi.aMapReGoecodeSearch(request)
        }
    }
}


// MARK: - Map Search Delegate
extension MainVC: AMapSearchDelegate {
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        guard let regeocode: AMapReGeocode = response.regeocode else { return }
        let addressComponent: AMapAddressComponent = regeocode.addressComponent
        let streetNumber: AMapStreetNumber = addressComponent.streetNumber
        let street: Street = Street(street: streetNumber.street,
                                    number: streetNumber.number,
                                    latitude: Double(streetNumber.location.latitude),
                                    longitude: Double(streetNumber.location.longitude),
                                    distance: streetNumber.distance,
                                    direction: streetNumber.direction)
        
        let address: Address = Address(province: addressComponent.province,
                                       city: addressComponent.city,
                                       citycode: addressComponent.citycode,
                                       district: addressComponent.district,
                                       adcode: addressComponent.adcode,
                                       township: addressComponent.township,
                                       towncode: addressComponent.towncode,
                                       neighborhood: addressComponent.neighborhood,
                                       building: addressComponent.building,
                                       street: street)
        LocationManager.address = address
        
        self.locationCity = address.city!
    }
}
