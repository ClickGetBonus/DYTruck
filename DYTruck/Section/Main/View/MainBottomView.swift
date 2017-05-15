//
//  MainBottomView.swift
//  DYTruck
//
//  Created by Lan on 17/4/17.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class MainBottomView: BaseXibView {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nowButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var backgroundLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var rowHeight: CGFloat = 50
    
    var locationBehavior: () -> Swift.Void = {}
    var completeEditBehavior: (MainBottomView) -> Swift.Void = { _ in}
    var requestSelectAddressBehavior: (Int) -> Swift.Void = { _ in }
    
    var departureTimeString: String = NSDate().string(withFormat: "YYYY年MM月dd日 HH:mm:ss")!
    var departureArray: [String] = [""]
    var destination: String = ""
    
    let topViewHeight: CGFloat = 50
    
    var cellIdentifiers: [String] = [MainAdressCell.className, MainAdressCell.className]
    var rowCount: Int {
        
        if self.pattern == .storage {
            return 1
        }
        
        var count = 0
        if timePattern == .order {
            count += 1
        }
        
        return count + departureArray.count + 1
    }
    
    
    func deleteAllSelection() {
        self.departureTimeString = NSDate().string(withFormat: "YYYY年MM月dd日 HH:mm:ss")!
        self.departureArray = [""]
        self.cellIdentifiers = [MainAdressCell.className, MainAdressCell.className]
        self.destination = ""
        self.tableView.reloadData()
        self.tableViewHeightConstraint.constant = CGFloat(self.rowCount) * self.rowHeight
        self.topView.layoutSubviews()
        self.contentView.layoutSubviews()
    }
    
    init(_ patter: Pattern) {
        super.init(frame: CGRect.zero)
        self.pattern = patter
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubviews() {
        
        switch self.pattern {
        case .storage:
            isShowTopView = false
            locationButton.isHidden = true
        default:
            isShowTopView = true
            locationButton.isHidden = false
        }
        
        self.tableView.layer.shadowColor = kRGBColorFromHex(0x0b0b0b).cgColor
        self.tableView.layer.shadowOpacity = 0.3
        self.tableView.layer.shadowRadius = 12
        self.tableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tableView.clipsToBounds = false
        
        self.tableView.register(UINib(nibName: MainAdressCell.className, bundle: nil),
                                forCellReuseIdentifier: MainAdressCell.className)
        self.tableView.register(UINib(nibName: MainDateCell.className, bundle: nil),
                                forCellReuseIdentifier: MainDateCell.className)
        
        self.updateTableViewHeight()
    }
    
    fileprivate var pattern: Pattern = .special
    
    private var _isShowTopView: Bool = true
    private var isShowTopView: Bool {
        set {
            
            if newValue == false {
                topViewHeightConstraint.constant = 0
            } else {
                topViewHeightConstraint.constant = topViewHeight
            }
            _isShowTopView = newValue
        }
        get {
            return _isShowTopView
        }
    }
    
    fileprivate var timePattern: TimePattern = .now {
        didSet {
            
            var leftPadding: CGFloat = 0
            switch timePattern {
            case .now:
                self.nowButton.setTitleColor(kRGBColorFromHex(0xf6a224), for: .normal)
                self.orderButton.setTitleColor(kRGBColorFromHex(0x999999), for: .normal)
                leftPadding = self.nowButton.left
                if (cellIdentifiers.contains(MainDateCell.className)) {
                    _ = cellIdentifiers.removeFirst()
                }
                
                UIView.animate(withDuration: 0.2) {
                    self.backgroundLeftConstraint.constant = leftPadding
                    self.tableViewHeightConstraint.constant = CGFloat(self.rowCount) * self.rowHeight
                    self.topView.layoutSubviews()
                    self.contentView.layoutSubviews()
                    self.tableView.deleteRow(at: IndexPath(row: 0, section: 0), with: .none)
                }
            case .order:
                self.orderButton.setTitleColor(kRGBColorFromHex(0xf6a224), for: .normal)
                self.nowButton.setTitleColor(kRGBColorFromHex(0x999999), for: .normal)
                leftPadding = self.orderButton.left
                cellIdentifiers.insert(MainDateCell.className, at: cellIdentifiers.startIndex)
                
                UIView.animate(withDuration: 0.2) {
                    self.backgroundLeftConstraint.constant = leftPadding
                    self.tableViewHeightConstraint.constant = CGFloat(self.rowCount) * self.rowHeight
                    self.topView.layoutSubviews()
                    self.contentView.layoutSubviews()
                    self.tableView.insertRow(at: IndexPath(row: 0, section: 0), with: .none)
                    
                }
            }
        }
    }
    func setAddress( _ address: String, in index: Int) {
        if index < departureArray.count {
            self.departureArray[index] = address
        } else {
            self.destination = address
        }
        
        self.tableView.reloadData()
        
        if self.isCompleteSelect() {
            self.completeEditBehavior(self)
        }
    }
    
    func isCompleteSelect() -> Bool {
        for v in departureArray {
            if v.isEmpty {
                return false
            }
        }
        
        if destination.isEmpty {
            return false
        }
        
        return true
    }
    
    fileprivate func addNewDepartureCell() {
        
        guard departureArray.count < 5 else {
            return
        }
        
        cellIdentifiers.insert(MainAdressCell.className, at: self.rowCount - 2)
        departureArray.append("")
        UIView.animate(withDuration: 0.2) {
            self.tableViewHeightConstraint.constant = CGFloat(self.rowCount) * self.rowHeight
            self.topView.layoutSubviews()
            self.contentView.layoutSubviews()
            self.tableView.insertRow(at: IndexPath(row: self.rowCount - 2, section: 0),
                                     with: .none)
        }
    }
    
    fileprivate func removeDepartureCell( at indexPath: IndexPath) {
        
        guard departureArray.count > 1 else {
            return
        }
        
        cellIdentifiers.remove(at: indexPath.row)
        departureArray.remove(at: (timePattern == .order) ? indexPath.row+1 : indexPath.row)
        UIView.animate(withDuration: 0.2) {
            self.tableViewHeightConstraint.constant = CGFloat(self.rowCount) * self.rowHeight
            self.topView.layoutSubviews()
            self.contentView.layoutSubviews()
            self.tableView.deleteRow(at: indexPath,
                                     with: .none)
        }
    }
    
    @IBAction func onClickNow(_ sender: Any) {
        self.timePattern = .now
    }
    
    
    @IBAction func onClickOrder(_ sender: Any) {
        self.timePattern = .order
    }
    
    
    @IBAction func onClickLocation(_ sender: Any) {
        
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        var converPoint = self.convert(point, to: self.tableView)
        if tableView.point(inside: converPoint, with: event) {
            return self.tableView.hitTest(converPoint, with: event)
        }
        
        converPoint = self.convert(point, to: topView)
        if topView.point(inside: converPoint, with: event) {
            return self.topView.hitTest(converPoint, with: event)
        }
        converPoint = self.convert(point, to: self.locationButton)
        if self.locationButton.point(inside: converPoint, with: event) {
            return self.locationButton
        }
        
        return nil
    }
}

//MARK: - UITableView
extension MainBottomView: UITableViewDelegate, UITableViewDataSource {
    
    func updateTableViewHeight() {
        self.tableViewHeightConstraint.constant = CGFloat(rowCount) * rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pattern == .storage {
            return 1
        } else {
            return self.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.pattern == .storage {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "neverUse")
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.width, height: rowHeight))
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = kRGBColorFromHex(0x343434)
            let numString = "12"
            let attributedString = NSMutableAttributedString(string: "深圳市 共\(numString)座")
            attributedString.addAttribute(NSForegroundColorAttributeName, value: kRGBColorFromHex(0xf6a224), range: NSMakeRange(5, numString.characters.count))
            label.attributedText = attributedString
            cell.addSubview(label)
            
            return cell
            
        } else {
            
            
            if cellIdentifiers[indexPath.row] == MainDateCell.className {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: MainDateCell.className) as! MainDateCell
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "YYYY-MM-dd HH:mm"
                cell.dateLabel.text = self.departureTimeString
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: MainAdressCell.className) as! MainAdressCell
                
                let index = (self.timePattern == .order) ? indexPath.row-1 : indexPath.row
                if index < departureArray.count {
                    if departureArray.count > 1 && indexPath.row > 0 {
                        cell.style = .departureAdd
                    } else {
                        cell.style = .departure
                    }
                    
                    cell.textField.text = self.departureArray[index]
                } else {
                    cell.style = .destination
                    cell.textField.text = self.destination
                }
                
                cell.rightButtonBehavior = { cell in
                    
                    switch cell.style {
                    case .departure:
                        self.addNewDepartureCell()
                    case .departureAdd:
                        self.removeDepartureCell(at: IndexPath(row: (self.tableView.indexPath(for: cell)?.row)!,
                                                               section: 0))
                    default:
                        break
                    }
                }
                
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if cellIdentifiers[indexPath.row] == MainDateCell.className {
            
            let timeSelection: [[String]] = [["今天", "明天", "后天"],
                                             ["00点", "01点", "02点", "03点", "04点", "05点", "06点", "07点", "08点", "09点", "10点", "11点", "12点", "13点", "14点", "15点", "16点", "17点", "18点", "19点", "20点", "21点", "22点", "23点"],
                                             ["00", "10", "20", "30", "40", "50"]]
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "YYYY-MM-dd HH:mm"
            let cell = tableView.cellForRow(at: indexPath) as! MainDateCell
            
            
            TLPicker.pickLinearData(timeSelection, for:UIApplication.shared.keyWindow?.rootViewController?.view, selectedBlock: {
                (isCancel, selections, indexs) -> Bool in
                
                if isCancel {
                    return true
                }
                
                let hour: String = (selections?[1])!
                let index = hour.index(hour.endIndex, offsetBy: -1)
                let timeString = "\((selections?[0])!) \(hour.substring(to: index)):\((selections?[2])!)"
                cell.dateLabel.text = timeString
                self.departureTimeString = timeString
                
                return true
            }).show(true)
            
            
            
            
            
            
        } else if cellIdentifiers[indexPath.row] == MainAdressCell.className {
            
            let index = (self.timePattern == .order) ? indexPath.row-1 : indexPath.row
            self.requestSelectAddressBehavior(index)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(self.rowHeight)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        if cell.responds(to:#selector(setter: UIView.layoutMargins)) {
        //            cell.layoutMargins = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        //        }
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        }
    }
}
