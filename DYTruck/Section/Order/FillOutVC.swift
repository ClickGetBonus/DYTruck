//
//  FillOutVC.swift
//  DYTruck
//
//  Created by Lan on 2017/5/7.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class FillOutVC: UITableViewController {
    
    
    let textFieldTag: Int = 653862
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    enum CellType {
        case name
        case weight
        case volume
        case quantity
        case deliveryName
        case deliveryPhone
        case receiverName
        case receiverPhone
        
        var identifier: String {
            switch self {
            case .name:
                return "GoodsNameCell"
            case .weight:
                return "GoodsWeightCell"
            case .volume:
                return "GoodsVolumeCell"
            case .quantity:
                return "GoodsQuantityCell"
            case .deliveryName:
                return "DeliveryNameCell"
            case .deliveryPhone:
                return "DeliveryPhoneCell"
            case .receiverName:
                return "ReceiverNameCell"
            case .receiverPhone:
                return "ReceiverPhoneCell"
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            case .quantity:
                return 115
            default:
                return 50
            }
        }
    }
    
    func fill( _ p:[String?]) {
            self.parameters = p
            self.tableView.reloadData()
    }
    
    
    var completeBehavior: ([String?]) -> Void = { _ in }
    
    func setCellTypes( _ types: [CellType]) {
        self.cellTypes = types
        self.tableView.reloadData()
    }
    
    fileprivate var cellTypes: [CellType] = [.name, .weight, .volume, .quantity]
    var parameters: [String?] = ["", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        
        var result: [String?] = []
        for i in 0 ..< self.cellTypes.count {
            let cell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0))!
            let textField = cell.viewWithTag(textFieldTag) as! UITextField
            result.append(textField.text)
        }
        
        self.completeBehavior(result)
        self.navigationController?.popViewController(animated: true)
    }
}

extension FillOutVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type.identifier)!
        let textField = cell.contentView.viewWithTag(textFieldTag) as! UITextField
        textField.text = parameters[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let type = cellTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type.identifier)!
        let textField = cell.contentView.viewWithTag(textFieldTag) as! UITextField
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = cellTypes[indexPath.row].cellHeight
        return height
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 0, section: 0))
    }
}
