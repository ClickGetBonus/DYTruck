//
//  IntegralVC.swift
//  DYTruck
//
//  Created by Lan on 17/4/25.
//  Copyright © 2017年 TL. All rights reserved.
//

import UIKit

class IntegralVC: UIViewController {

    @IBOutlet weak var integralLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackItem()
        self.tableView.register(IntegralCell.nib, forCellReuseIdentifier: IntegralCell.className)
        self.tableView.rowHeight = 85.0
    }

}


// MARK: - TableView
extension IntegralVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IntegralCell.className) as! IntegralCell
        return cell
    }
    
}
