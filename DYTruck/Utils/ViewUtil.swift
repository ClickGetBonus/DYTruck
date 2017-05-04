//
//  ViewUtil.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addCornerBorder(_ color: UIColor, _ width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    var xibName: String {
        let clzzName = NSStringFromClass(self.classForCoder)
        let nameArray = clzzName.components(separatedBy: ".")
        var xibName = nameArray[0]
        if nameArray.count == 2 {
            xibName = nameArray[1]
        }
        return xibName
    }
    
    static var className: String {
        let clzzName = NSStringFromClass(self.classForCoder())
        let nameArray = clzzName.components(separatedBy: ".")
        var xibName = nameArray[0]
        if nameArray.count == 2 {
            xibName = nameArray[1]
        }
        return xibName
    }
    
    func loadViewWithNibName(_ fileName: String, owner: AnyObject) -> UIView {
        let nibs = Bundle.main.loadNibNamed(fileName, owner: owner, options: nil)
        return nibs![0] as! UIView
    }
    
    func initFromXIB() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: xibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        return view
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
    
}




// MARK: - Animation
extension UIView {
    
    func transitionIn(_ offset: UIOffset, complete: @escaping () -> Void) {
        
        let pointFrame = self.frame
        
        var beginFrame = self.frame
        beginFrame.origin.x += offset.horizontal
        beginFrame.origin.y += offset.vertical
        self.frame = beginFrame
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = pointFrame
        }) { _ in
            complete()
        }
    }
    
    
    func transitionOut(_ offset: UIOffset, complete: @escaping () -> Void) {
        
        let pointFrame = CGRect(x: self.left + offset.horizontal,
                                y: self.top + offset.vertical,
                                width: self.width,
                                height: self.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = pointFrame
        }) { _ in
            complete()
        }
    }
    
    func rotation(by value: Double) {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = value
        anim.duration = 0.2
        anim.isRemovedOnCompletion = true
        self.layer.add(anim, forKey: nil)
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2) {
            self.transform = self.transform.rotated(by: CGFloat(value))
        }
    }
}

