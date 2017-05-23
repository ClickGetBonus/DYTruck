//
//  SpecialOrderVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/6.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class SpecialOrderVC: UITableViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deliveryNameLabel: UILabel!
    @IBOutlet weak var deliveryPhoneLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    
    
    @IBOutlet weak var initiatePriceLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var overPriceLabel: UILabel!
    
    
    var goodsParameters: [GoodsParameterType: String] = [.name: "", .quantity: ""]

    @IBOutlet weak var goodsEditScrollView: UIScrollView!
    @IBOutlet weak var goodsEditPlaceholderLabel: UILabel!
    @IBOutlet weak var goodsNameButton: UIButton!
    
    @IBOutlet weak var goodsQuantityButton: UIButton!
    @IBOutlet weak var goodsWeightButton: UIButton!
    @IBOutlet weak var goodsVolumeButton: UIButton!
    
    @IBOutlet weak var carSelectScrollView: UIScrollView!
    @IBOutlet weak var smallCarView: UIView!
    @IBOutlet weak var middleCarView: UIView!
    @IBOutlet weak var smallTruckView: UIView!
    @IBOutlet weak var middleTruckView: UIView!
    let imageViewTag = 11
    let labelTag = 12
    
    var autos: [Auto] = []
    
    var carSelection: Int = 0 {
        didSet {
            guard carSelection <= 3 else {
                return
            }
            let views = [smallCarView, middleCarView, smallTruckView, middleTruckView]
            
            for (index, parentView) in views.enumerated() {
                
                let imageView = parentView?.viewWithTag(imageViewTag) as! UIImageView
                let label = parentView?.viewWithTag(labelTag) as! UILabel
                
                var imageName = "dd_car_0"
                imageName.append("\(index+1)")
                if index == carSelection {
                    imageName.append("a")
                    label.textColor = kRGBColorFromHex(0xf6a224)
                } else {
                    label.textColor = kRGBColorFromHex(0x333333)
                }
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var departureDateString: String = ""
    var departureDate: Date = Date()
    var locations: [MapPOI] = [MapPOI()]
    var destination: MapPOI = MapPOI()
    var approach: MapPOI = MapPOI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackItem()
        self.dateLabel.text = self.departureDateString
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        self.tableView.register(OrderAddressCell.nib, forCellReuseIdentifier: OrderAddressCell.className)
        self.tableView.register(GoodsEditCell.nib, forCellReuseIdentifier: GoodsEditCell.className)
        
        self.getAutos()
    }
    
    
    
    func setBackItem() {
        
        let backItem = UIBarButtonItem(image: UIImage(named: "ty_backarrow"),
                                       style: .done,
                                       target: self,
                                       action: #selector(backMain))
        backItem.tintColor = UIColor.lightGray
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func backMain() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func configure( _ dateString: String, location: [MapPOI], destination: MapPOI) {
        self.departureDateString = dateString
        self.destination = destination
        if location.count > 0 {
            self.locations = location
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goGoodsEdit" {
            let vc = segue.destination as! FillOutVC
            vc.setCellTypes([.name, .quantity])
            vc.fill([self.goodsParameters[.name]!, self.goodsParameters[.quantity]!])
            vc.title = "物品"
            vc.completeBehavior = { results in
                self.goodsParameters[.name] = results[0] ?? ""
                self.goodsParameters[.quantity] = results[1] ?? ""
                
                let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 1)) as! GoodsEditCell
                cell.updateBy(parameters: self.goodsParameters)
            }
        } else if segue.identifier == "goDeliveryEdit" {
            let vc = segue.destination as! FillOutVC
            vc.setCellTypes([.deliveryName, .deliveryPhone])
            vc.fill([deliveryNameLabel.text, deliveryPhoneLabel.text])
            vc.title = "发货人编辑"
            vc.completeBehavior = { results in
                self.deliveryNameLabel.text = results[0]
                self.deliveryPhoneLabel.text = results[1]
            }
        } else if segue.identifier == "goReceiverEdit" {
            let vc = segue.destination as! FillOutVC
            vc.setCellTypes([.receiverName, .receiverPhone])
            vc.fill([receiverNameLabel.text, receiverPhoneLabel.text])
            vc.title = "收货人编辑"
            vc.completeBehavior = { results in
                self.receiverNameLabel.text = results[0] ?? ""
                self.receiverPhoneLabel.text = results[1] ?? ""
            }
        }
    }
    
    
    @IBAction func onCarSelectButton(_ sender: UIButton) {
        self.carSelection = sender.tag
    }
    
    
    //MARK: - Network
    func getAutos() {
        
        //let getAutosApi = GetAutosApi(city: <#T##String#>, type: <#T##OrderPattern#>)
    }
}


extension SpecialOrderVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.locations.count + 3
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderAddressCell.className) as! OrderAddressCell
            if indexPath.row <= locations.count {
                cell.configure(.location, address: locations[indexPath.row-1].name)
            } else if indexPath.row == locations.count+1 {
                cell.configure(.approach, address: approach.name)
            } else {
                cell.configure(.destination, address: destination.name)
            }
            return cell
        } else if indexPath.section == 1 && indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GoodsEditCell.className) as! GoodsEditCell
            cell.updateBy(parameters: self.goodsParameters)
            return cell
        }

        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            return 44
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            
            if indexPath.row == 0 {
                
                let timeSelection: [[String]] = [["今天", "明天", "后天"],
                                                 ["00点", "01点", "02点", "03点", "04点", "05点", "06点", "07点", "08点", "09点", "10点", "11点", "12点", "13点", "14点", "15点", "16点", "17点", "18点", "19点", "20点", "21点", "22点", "23点"],
                                                 ["00", "10", "20", "30", "40", "50"]]
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "YYYY-MM-dd HH:mm"
                
                
                
                TLPicker.pickLinearData(timeSelection, for:self.navigationController?.view, selectedBlock: {
                    (isCancel, selections, indexs) -> Bool in
                    
                    if isCancel {
                        return true
                    }
                    
                    let hour: String = (selections?[1])!
                    let index = hour.index(hour.endIndex, offsetBy: -1)
                    let timeString = "\((selections?[0])!) \(hour.substring(to: index)):\((selections?[2])!)"
                    self.departureDateString = timeString
                    self.dateLabel.text = self.departureDateString
                    
                    return true
                }).show(true)
                
            } else {
                
                let cell = tableView.cellForRow(at: indexPath) as! OrderAddressCell
                let addressSelectVC = AddressSelectVC()
                self.navigationController?.addChildViewController(addressSelectVC)
                self.navigationController?.view.addSubview(addressSelectVC.view)
                addressSelectVC.view.frame = (self.navigationController?.view.bounds)!
                
                addressSelectVC.view.transitionIn(UIOffset(horizontal: 0, vertical: (self.navigationController?.view.height)!), complete: { })
                //                addressSelectVC.tableViewEdgeInsets = UIEdgeInsets(top: 10,
                //                                                                   left: 10,
                //                                                                   bottom: 10,
                //                                                                   right: 10)
                addressSelectVC.selectCallBack = { address in
                    
                    if indexPath.row <= self.locations.count {
                        self.locations[indexPath.row-1] = address
                    } else if indexPath.row == self.locations.count+1 {
                        self.approach = address
                    } else {
                        self.destination = address
                    }
                    
                    cell.textField.text = address.name
                }
                
                addressSelectVC.dismissBehavior = { vc in
                    vc.view.transitionOut(UIOffset(horizontal: 0, vertical: (self.navigationController?.view.height)!), complete: {
                        vc.view.removeFromSuperview()
                        vc.removeFromParentViewController()
                    })
                }
                
            }
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            self.performSegue(withIdentifier: "goGoodsEdit", sender: nil)
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        if indexPath.section == 0 {
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 1, section: 0))
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 2, section: 1))
        }

        return super.tableView(tableView, indentationLevelForRowAt: indexPath)
    }
}
