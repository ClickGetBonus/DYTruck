//
//  ViewControllerUtil.swift
//  DYTruck
//
//  Created by Lan on 17/4/15.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation


extension UIViewController {
    static func nibInstance() -> UIViewController {
        let name = (self.classForCoder().description() as NSString).components(separatedBy: ".")[1] as String
        let vc = UIViewController(nibName: name, bundle: Bundle.main)
        
        return vc
    }
    
    func nibViewInstance( _ nibName: String) -> UIView {
        let nibs = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        return nibs![0] as! UIView
    }
    
    
    func setupBackItem() {
        
        let backItem = UIBarButtonItem(image: UIImage(named: "ty_backarrow"),
                                       style: .done,
                                       target: self,
                                       action: #selector(onBack))
        backItem.tintColor = UIColor.lightGray
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    func onBack() {
        if (self.navigationController?.viewControllers.count)! > 0 {
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
